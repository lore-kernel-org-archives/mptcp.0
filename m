Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D641C84D7;
	Mon,  3 Nov 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134242; cv=none; b=VpoOM4xo4VTe1DC6Ki32A026/oHvI36XNJmha4DBIAuba3OcmqBqO8MVFvxSB8S38J9BPFEKmLYpzQxgZdb0bCM+Tq9+BfAoAecRKPi8J512/vyb6J4cYiq7IylH+2EFYhulwvH0vW9Mz/uJbhVOccfmY6dEsvDa7cS2QsNtMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134242; c=relaxed/simple;
	bh=tDhuDrXSEaSMJD2AhZC1VhTvwNxZ4BZcHTIXrIAUyQE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=PFzKj6Y2CLnDR2h4NSV1KTSvo8KZsZzf0sZGmDCDNa8o/1q/i6Ua0849mmPDmkduKIv61zGNg68DI92xcd3v5xML8mwBe7q8ok7G0x5eD8FZgOW6KhynbcB2/aJKPFUhsS+ho+shBaPViHEv97Ryq0FwQZwQ+LIFkX/WV9f1RAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oemEYoBe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oemEYoBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7369C4CEF7;
	Mon,  3 Nov 2025 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762134242;
	bh=tDhuDrXSEaSMJD2AhZC1VhTvwNxZ4BZcHTIXrIAUyQE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=oemEYoBecLjIIW/0MnEVcBF9+OERhUobgI38F9bcCiYAgnCcCP/nWBHWGPE2G6GqO
	 lxD7A0W5RRSZZUE6CBF4ZKamfI+QSbjVwUgEbt8Rx5IFPmvEFD5jfhiJeNzxa26IuI
	 yEJ+NDe8hzt61YQkjtg3feg7/CWzj9P5Bh2898PI=
Subject: Patch "x86/boot: Compile boot code with -std=gnu11 too" has been added to the 5.10-stable tree
To: adobriyan@gmail.com,ardb@kernel.org,dave.hansen@linux.intel.com,gregkh@linuxfoundation.org,hpa@zytor.com,matttbe@kernel.org,mingo@kernel.org,mptcp@lists.linux.dev,nathan@kernel.org,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 10:43:52 +0900
In-Reply-To: <20251017-v5-10-gcc-15-v1-1-cdbbfe1a2100@kernel.org>
Message-ID: <2025110352-diner-juror-83eb@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    x86/boot: Compile boot code with -std=gnu11 too

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-boot-compile-boot-code-with-std-gnu11-too.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Oct 18 01:53:53 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:53:25 +0200
Subject: x86/boot: Compile boot code with -std=gnu11 too
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,  Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>,  "H. Peter Anvin (Intel)" <hpa@zytor.com>,  Nathan Chancellor <nathan@kernel.org>,  Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <20251017-v5-10-gcc-15-v1-1-cdbbfe1a2100@kernel.org>

From: Alexey Dobriyan <adobriyan@gmail.com>

commit b3bee1e7c3f2b1b77182302c7b2131c804175870 upstream.

Use -std=gnu11 for consistency with main kernel code.

It doesn't seem to change anything in vmlinux.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183
[ This kernel version doesn't build with GCC 15:

    In file included from include/uapi/linux/posix_types.h:5,
                     from include/uapi/linux/types.h:14,
                     from include/linux/types.h:6,
                     from arch/x86/realmode/rm/wakeup.h:11,
                     from arch/x86/realmode/rm/wakemain.c:2:
    include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
       11 |         false   = 0,
          |         ^~~~~
    include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
    include/linux/types.h:30:33: error: 'bool' cannot be defined via 'typedef'
       30 | typedef _Bool                   bool;
          |                                 ^~~~
    include/linux/types.h:30:33: note: 'bool' is a keyword with '-std=c23' onwards
    include/linux/types.h:30:1: warning: useless type name in empty declaration
       30 | typedef _Bool                   bool;
          | ^~~~~~~

  The fix is similar to commit ee2ab467bddf ("x86/boot: Use '-std=gnu11'
  to fix build with GCC 15") which has been backported to this kernel.

  Note: In < 5.18 version, -std=gnu89 is used instead of -std=gnu11, see
  commit e8c07082a810 ("Kbuild: move to -std=gnu11"). I suggest not to
  modify that in this commit here as all the other similar fixes to
  support GCC 15 set -std=gnu11. This can be done in a dedicated commit
  if needed.
  There was a conflict, because commit 2838307b019d ("x86/build: Remove
  -m16 workaround for unsupported versions of GCC") is not in this
  version and change code in the context. -std=gnu11 can still be added
  at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,7 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/arch-back-to-std-gnu89-in-v5.18.patch
queue-5.10/x86-boot-compile-boot-code-with-std-gnu11-too.patch
queue-5.10/tracing-fix-declaration-after-statement-warning.patch
