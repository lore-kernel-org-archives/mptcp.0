Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBF248F73;
	Mon,  3 Nov 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134056; cv=none; b=AsB8g83kjUCZSE39FSNBUfqTtUp1vvfoGUU12W5GOEYoi6TC2GRaEWyyehH6UOlCG2HphW7RTQ1luG90H8YOFgtdn6CatkXHucecooXNPdQPtV0DXOnPxBcorQFOt74uqjNjwlworwiM4Thcuo3ZKIl0+Pk4tsWQb8m3Z02Zeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134056; c=relaxed/simple;
	bh=yvps5sKgYIF8DD30ED/3O31KUjHzlu23mgugeHRqaJc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=kXZ8irRPEOorx1iim/HCoYVoZ0RJgX1z0EfFjB1Nma0RR4izqQ1OMYHun/h/jpZLy7JiHkKzSOA3ORMSoBDxZASWIgIjJTuf44FOrNz4evFMRHDdg7kUBpBEaQZIZRPjM8IK27uOOMOsGTdw5T8iVYM+dgwfoHdXV0LgKgblCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TrmvpjvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TrmvpjvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0AC4CEF7;
	Mon,  3 Nov 2025 01:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762134056;
	bh=yvps5sKgYIF8DD30ED/3O31KUjHzlu23mgugeHRqaJc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=TrmvpjvJ4wmiXy8gS8uJKTjxygWEPBs1PHJidRD5wBXIfAovf59XaoR+ci0J0fuO2
	 gr/wA2eWcy0xMi/5slu7IPOKglOGFgSK3aVjmu2bgJg8REEQWLmaMWFHTo84bxaOMs
	 DfXypNz7dFHlKw0HJ2SDs2lDzuXxnicQZrki+698=
Subject: Patch "x86/boot: Compile boot code with -std=gnu11 too" has been added to the 5.15-stable tree
To: adobriyan@gmail.com,ardb@kernel.org,dave.hansen@linux.intel.com,gregkh@linuxfoundation.org,hpa@zytor.com,matttbe@kernel.org,mingo@kernel.org,mptcp@lists.linux.dev,nathan@kernel.org,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 10:38:11 +0900
In-Reply-To: <20251017-v5-15-gcc-15-v1-1-da6c065049d7@kernel.org>
Message-ID: <2025110311-attractor-parameter-4e55@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-boot-compile-boot-code-with-std-gnu11-too.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Oct 18 01:24:24 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:24:00 +0200
Subject: x86/boot: Compile boot code with -std=gnu11 too
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,  Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>,  "H. Peter Anvin (Intel)" <hpa@zytor.com>,  Nathan Chancellor <nathan@kernel.org>,  Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <20251017-v5-15-gcc-15-v1-1-da6c065049d7@kernel.org>

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
  if needed. ]
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
@@ -24,7 +24,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/arch-back-to-std-gnu89-in-v5.18.patch
queue-5.15/x86-boot-compile-boot-code-with-std-gnu11-too.patch
queue-5.15/mptcp-drop-bogus-optimization-in-__mptcp_check_push.patch
queue-5.15/mptcp-restore-window-probe.patch
queue-5.15/revert-docs-process-howto-replace-c89-with-c11.patch
