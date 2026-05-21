Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC63C3BFF;
	Thu, 21 May 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363880; cv=none; b=lMXvMXmw0/tVCjq/3/hoFq0p4Y9kvLFrgbO+3jryhqcCzCPuz4EfnmnDlhLaQ7KIgM9uPcf+m7ahG1p2OU/R3CoAYimdaYHFhceWvdARdDToNK9hQq/Y7FNY0oPr2aAeiheeNtUfShnboVufO7pqVqFdii7ycOD5Vf/eI1PAA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363880; c=relaxed/simple;
	bh=hK0OLe1zddJ0BvIptcnAa4HJXke4ZAh26NCR2X5uQGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmBuYD/mTAwY876l/pKsdfImYJBK+bjU0ganKkm/f1+Un4SiqlZx51ziem1ym+2Yc6ktfQ+Qpgz6XZLr2kbEmC2OnKo3UHBAMDgalQRIZmBeQxOZSkF6Cl+Uo/Wrssas5UCIRNpqvBcQEQ+uF5X2oKVmtCtkXA1eQrd4ZDYe5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIjXS8hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIjXS8hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2241F000E9;
	Thu, 21 May 2026 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363879;
	bh=TiqcdHFX0yDMrBD60DT4cQ7gt/Ic0YOEFSbvRDBHO7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bIjXS8hfVSHOAevw1TTlBno/poe3j1jLXhvmbzzf3W6bZksyh2LYBmjtZjqnx0dp8
	 jrsK5Zm48AhZgDQcOFFCxD1czwPytiv5FTvl2oDknc6eZyKh+KESfCPch5rpKTef4C
	 U41dB2Vdrlh2F47b1rl2f02kyJ5nKnqgBqdgXQczHKWlEoaXulH9Xz1iWiM4Aqazfy
	 bZmx1nvMrzTjSGU/3a1YgozUUgvWpPz59LpQUUYcme4Rvn3Yd95d1f/vrMA3lTk1jB
	 pkKfylxWk63SHsPwLad0Wv8bPIYFebGCYUjtIs1ol5Ayl2vVHJ6oKqPXnYyrER4lfL
	 Twqk8rcjw1xng==
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Geliang Tang <geliang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH v2] selftests: harness: fix pidfd leak in __wait_for_test
Date: Thu, 21 May 2026 13:44:30 +0200
Message-ID: <20260521-brauen-situation-171ecf2a273f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
References: <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org; h=from:subject:message-id; bh=hK0OLe1zddJ0BvIptcnAa4HJXke4ZAh26NCR2X5uQGo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTxfVBax7JrW/cXlVPP2ubeYlT9dfRJec7Bc7a5l2bu6 joRKdKS2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZ5MY/nCdL/n5q+DNZnbZ 0xc/fz8jtG/1ZrY5stv/cAeFt2iVbFrE8Ff2t0La/58zryyxZGOx57E6+OXcJGOWW9t53S9KLeZ 0TGMEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 20 Apr 2026 17:45:28 +0800, Geliang Tang wrote:
> Fix the pidfd leak in kselftest_harness.h's __wait_for_test() where
> childfd = syscall(__NR_pidfd_open, t->pid, 0) is never closed.

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] selftests: harness: fix pidfd leak in __wait_for_test
      https://git.kernel.org/vfs/vfs/c/0eb307d61317
