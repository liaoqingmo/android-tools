# libext4_utils
# =========================================================

LIBEXT4_UTILS_ARCHIVE := obj/libext4_utils/libext4_utils.a

LIBEXT4_UTILS_CXXFLAGS := \
    -I$(srcdir)/core/base/include \
    -I$(srcdir)/core/include \
    -I$(srcdir)/core/libsparse/include \
    -I$(srcdir)/extras/ext4_utils/include \
    -I$(srcdir)/include \
    -I$(srcdir)/selinux/libselinux/include \

LIBEXT4_UTILS_SRC_FILES := \
    ext4_sb.cpp \
    ext4_utils.cpp \
    wipe.cpp \

LIBEXT4_UTILS_C_OBJ_FILES := \
    $(patsubst %.c,obj/libext4_utils/%.o,$(filter %.c,$(LIBEXT4_UTILS_SRC_FILES)))

LIBEXT4_UTILS_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libext4_utils/%.o,$(filter %.cpp,$(LIBEXT4_UTILS_SRC_FILES)))

DIRS += $(dir $(LIBEXT4_UTILS_C_OBJ_FILES) $(LIBEXT4_UTILS_CXX_OBJ_FILES))

libext4_utils: $(LIBEXT4_UTILS_ARCHIVE)

$(LIBEXT4_UTILS_ARCHIVE): $(LIBEXT4_UTILS_C_OBJ_FILES) $(LIBEXT4_UTILS_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBEXT4_UTILS_C_OBJ_FILES): obj/libext4_utils/%.o: $(srcdir)/extras/ext4_utils/%.c | dirs
	$(CC) $(CFLAGS) $(LIBEXT4_UTILS_CFLAGS) -c -o $@ $^

$(LIBEXT4_UTILS_CXX_OBJ_FILES): obj/libext4_utils/%.o: $(srcdir)/extras/ext4_utils/%.cpp | dirs
	$(CXX) $(CXXFLAGS) $(LIBEXT4_UTILS_CXXFLAGS) -c -o $@ $^
