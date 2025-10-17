Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F842EB5D4;
	Fri, 17 Oct 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720029; cv=none; b=HWerQlJ2Dfli+wm4vWtL3gL9tA+8jgad0FlDlKCrxQsMJrbae8x5r1YqfypmRxz9uMNjZmeTIj6FLd23GsWvopM/g70NSkKZ+FiOTa8AHP8mW5IV4naK7SD/PRUXSBLDXpNwUGSetTIOH8hUdcbytlvNu8OoR/KWUTHoRh3k9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720029; c=relaxed/simple;
	bh=4A/Gom1S5Sj6N0gvANEskHHVlTQ6OjuhoCGjWOpny8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YYWv/fhGInKovXLpRNnF0M8vZGBAVWzJPhZK1QtH1e3sZWRZGLrtlS+4RnwfuW8HF+oeqgJ4maf4bo0Ci56fFA5Rj3hVXBwgmkwq4RchsM13ibq4IskMF6I8eYE5iqgG7jvy9o+ingcC9HlkRVUTJVxdFRok3Uj9atdD3QeJFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhFcFPPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhFcFPPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58273C4CEE7;
	Fri, 17 Oct 2025 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760720029;
	bh=4A/Gom1S5Sj6N0gvANEskHHVlTQ6OjuhoCGjWOpny8o=;
	h=From:Subject:Date:To:Cc:From;
	b=PhFcFPPuWpArYs2fd8b6H1rSW+ftbvDWdHwUJaENOBuyTn6SwCJLlDS08yLnnQEme
	 rWX8T/hJ2lnGtRy/R5d6GlNqchNhmjWQ+4qikYHuV27NBO31J75YpD4pI84yAIUL7p
	 P9fGsNFuwx7RxKi6HWquXHloTdpTwDafDFWSjomL1COL7Cm12FSTQY6bl4dUj7kzfj
	 is63CifcoVuMrWZcQ8ZZscFw/8fMQNfn8VCCuRmjsINjTyek/UTMAamNB+0EM5jTlW
	 dmJ5hnZhf3mss1Glf0LSdpuVT5UO9jzFGIPlcTQgat7A2o5MYinKqkqlIw/Z1eEjDM
	 9p1AfukaLIXkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.10.y 0/3] v5.10: fix build with GCC 15
Date: Fri, 17 Oct 2025 18:53:24 +0200
Message-Id: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIR08mgC/x2MQQqAMAzAviI9W2mHY+JXxMOYnfaisoEo4t+dH
 hNIbsiSVDL01Q1JDs26rQW4riAsfp0FdSoMhoxlYoeHRSacQ0C26KfPRte10UFJ9iRRz383gG2
 YmgvG53kBqftayGYAAAA=
X-Change-ID: 20251017-v5-10-gcc-15-ad2510f784f7
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Douglas Raillard <douglas.raillard@arm.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4A/Gom1S5Sj6N0gvANEskHHVlTQ6OjuhoCGjWOpny8o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+lUzNDq7cGut28RjXrPXOlyqZV/24/uVafmECY9KOO
 6vi72uVdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEaD8jw2bG1oh7uaUeHTdq
 qy6qykws7pVujD6mWua93FG5TPzvDkaGjweyF/h9nzo7rPiFXUfP5e/mhvtls5MEG747C4aw7pn
 DCQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This kernel version doesn't build with GCC 15:

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

I initially fixed this by adding -std=gnu11 in arch/x86/Makefile, then I
realised this fix was already done in an upstream commit, created before
the GCC 15 release and not mentioning the error I had. This is the first
patch.

When I was investigating my error, I noticed other commits were already
backported to stable versions. They were all adding -std=gnu11 in
different Makefiles. In their commit message, they were mentioning
'gnu11' was picked to use the same as the one from the main Makefile.
But this is not the case in this kernel version. Patch 2 fixes that.

Finally, I noticed an extra warning that I didn't have in v5.15. Patch 3
fixes that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Alexey Dobriyan (1):
      x86/boot: Compile boot code with -std=gnu11 too

Matthieu Baerts (NGI0) (2):
      arch: back to -std=gnu89 in < v5.18
      tracing: fix declaration-after-statement warning

 arch/parisc/boot/compressed/Makefile  | 2 +-
 arch/s390/Makefile                    | 2 +-
 arch/s390/purgatory/Makefile          | 2 +-
 arch/x86/Makefile                     | 2 +-
 arch/x86/boot/compressed/Makefile     | 2 +-
 drivers/firmware/efi/libstub/Makefile | 2 +-
 kernel/trace/trace_events_synth.c     | 3 ++-
 7 files changed, 8 insertions(+), 7 deletions(-)
---
base-commit: a32db271d59d9f35f3a937ac27fcc2db1e029cdc
change-id: 20251017-v5-10-gcc-15-ad2510f784f7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

