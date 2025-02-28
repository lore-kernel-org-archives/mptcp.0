Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4614A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749501; cv=none; b=GXTKjVRKMmwBlJRfCdjJ7KqmSrpf4EYqbn5rOhNmyl2pkigNjDDjJEzzVnyVIHMasK6MkPYXysb3OBjn9rHike8HcbkaLX61Ex77uPawbYbsLdKXam5KAg9iuVVWaFkCL7R+pWpKThiHAUeI1CSp+3PAeLO9UkeMoCnym7WpAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749501; c=relaxed/simple;
	bh=tPbEbtXF2Ypxj/8ZR/+T2bdjMHl5GduIMIZ/mJZAEgQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AwhaWDsidlT7wcgDDhaEjAJi1obW7/nKlJhhxu4N7HfWsDB4ZmcGY4jhG7cTLXX+1JeLzsplfymxi89TU6gs9UqPewQFhuQx1crFmnrW8CGq3/LaD4C71oei2HFpLrN3/tW0PXa7rSOJNLXdOzkkjYLlTgus/jQQQR0X3ljnCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stiCM8D5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stiCM8D5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77BFC4CED6;
	Fri, 28 Feb 2025 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749500;
	bh=tPbEbtXF2Ypxj/8ZR/+T2bdjMHl5GduIMIZ/mJZAEgQ=;
	h=From:Subject:Date:To:Cc:From;
	b=stiCM8D5+0TmDmgnUCPS1RXDM1H8/4/p6OsIdaQAnPdadsihcT7+A9TSRIjQ5bu70
	 A25TUNHEXaCVMdNQR0tSUNJO2mc9fQyycZ/FmHIkkgXDnafRrfi2qpdvDjXF3a4AOh
	 4G3/LnIjZv40F+ob0A2AxtIdcakpXpAKVwG8C/2KL52/FvVFU9To1ZU9XoeLPg+2KA
	 VvQuMMESgTegiqWyQr01+/6G82VEzx+g7vsIZi2TKuTNvQuPetj9H32d72ZKqMXRBd
	 g7myMySKbEO7agIqzNUxU3+6xOScDmTaMMrkGPWLesv1LbLANHdakraC/pYqgFrxc2
	 Q7Qq0BdyqiyRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 00/14] mptcp: pm: code reorganisation
Date: Fri, 28 Feb 2025 14:31:20 +0100
Message-Id: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKi6wWcC/32NwQ6CMBBEf4Xs2TWlWIie+A/DQdoVGqVttoRgC
 P/uBu8e5jCZNzMbZGJPGW7FBkyLzz4GMfpUgB0fYSD0TjxopY3SusEpzTZhmpAp8oA2OsKyksR
 UqnfKgDQT09Ovx+odfoVA6wydZKPPc+TPcbiUB/F3eylRoe0vddOoay1qX8SB3mchoNv3/QvTu
 eLZwwAAAA==
X-Change-ID: 20250227-mptcp-pm-reorg-code-13227530bd05
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4838; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tPbEbtXF2Ypxj/8ZR/+T2bdjMHl5GduIMIZ/mJZAEgQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq5dwOzfMPQH+HwmtmHnzen6kPkucUYpN7EH
 rj6iyBYO0SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6uQAKCRD2t4JPQmmg
 c5SgD/sHGOKEKEf6WtJajq8n8COLeNS2RnGjHrMbTpKpolHCjvLMjksozVHcLsK265097raFMAR
 8Ai0fmw+ImmrIvRz3kv5/+qW5DKmlklTHB+z9sqGeYTAYPMbMoeXjcBHRCsffKAbfYve/Rx2jhB
 VvDWs5OqOOdpdQrGbIo3hEiqoAf2vmCg3RhCazbPaiAQFoGerQ88M0JXtHyo2Zo+bHUR+E1b+nL
 Y2+lCz+Bpw+2uuECab7YlZ/lUSsofy4+tql68BwKkvC3/NsJaYKmjtT4hfdU9nykyKGNvWIe4FT
 R6cj3uNqdSl6K8GwdyW6RAnQBz5n9xudnY0Mg1WjA526i6oAU9WX0NBpmXcGN3S/SfPIQUtN18s
 RsRsEBKsPN/0PoiH72P7FZi9kPHO4yMEQIbfibT1cGH2yE3TOCebievWofaz8kHdZQfvlu78nzc
 FB0veDzrBCQpGIhoCqmzOpovJrrDdk1cKusN14cGGtBjclhV1HD3ezt94bFBmenWR6eD30sdy/p
 FA9wjzKCYISanJtF7y0XvLtzbVzj9Hx3vZh2zkvGZP1IesKGPrquRnklbq3rX9bDMtEU4aSgtc5
 oGG8jDS4zEcr9AEHs/q3Fl6EuXE5BI12SNhp0F2xo5usqTLWkM0WCRiiJyvazQFsFgV3KFHuvsc
 eBKbRHapk70DCLQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

I have been thinking about that during the past couple of months, but
now, with the recent modifications done by Geliang, and the associated
reviews, I really think it is time to reorganise the code around the
path-managers to avoid confusions, and a mix of code used in different
conditions.

I hope this will not cause too many issues with the in-progress patches.
I tried only to move the code around, and minimise the functions
renaming. Then, to switch to the new code, it might be easier to simply
copy your modified code from the old place to the new one. In other
words, duplicate the net/mptcp directory, then do a rebase, resolve the
conflicts with 'git restore --ours', then reapply the modifications by
copying your old code to the new place. If it is too difficult, please
let me know.

Before this series, the PM code was dispersed in different places:

- pm.c had common code for all PMs

- pm_netlink.c was supposed to be about the in-kernel PM, but also had
  exported common helpers, callbacks used by the different PMs, NL
  events for PM userspace daemon, etc. quite confusing.

- pm_userspace.c had userspace PM only code, but using specific
  in-kernel PM helpers

To clarify the code, a reorganisation is suggested here, only by moving
code around, and small helper renaming to avoid confusions:

- pm_netlink.c now only contains common PM Netlink code:
  - PM events: this code was already there
  - shared helpers around Netlink code that were already there as well
  - shared Netlink commands code from pm.c

- pm_kernel.c now contains only code that is specific to the in-kernel
  PM. Now all functions are either called from:
  - pm.c: events coming from the core, when this PM is being used
  - pm_netlink.c: for shared Netlink commands
  - mptcp_pm_gen.c: for Netlink commands specific to the in-kernel PM
  - sockopt.c: for the exported counters per netns

- pm.c got many code from pm_netlink.c:
  - helpers used from both PMs and not linked to Netlink
  - callbacks used by different PMs, e.g. ADD_ADDR management
  - some helpers have been renamed to remove the '_nl' prefix, and they
    have been marked as 'static'.

- protocol.h has been updated accordingly:
  - some helpers no longer need to be exported
  - new ones needed to be exported: they have been prefixed if needed.

The code around the PM is now less confusing, which should help for the
maintenance in the long term.

This will certainly impact future backports, but because other cleanups
have already done recently, and more are coming to ease the addition of
a new path-manager controlled with BPF (struct_ops), doing that now
seems to be a good time. Also, many issues around the PM have been fixed
a few months ago while increasing the code coverage in the selftests, so
such big reorganisation can be done with more confidence now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Addressing Geliang's comments
- The renaming of common helpers have been done in dedicated patches
- Some helpers have been kept where they were in pm.c, except one now in
  a dedicated patch.
- The last patch has been split in smaller chunks, only moving code from
  one file to another to help with the reviews.
- Link to v1: https://lore.kernel.org/r/20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org

---
Matthieu Baerts (NGI0) (14):
      mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_work
      mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received
      mptcp: pm: remove '_nl' from mptcp_pm_nl_subflow_chk_stale()
      mptcp: pm: remove '_nl' from mptcp_pm_nl_is_init_remote_addr
      mptcp: pm: kernel: add '_pm' to mptcp_nl_set_flags
      mptcp: pm: avoid calling PM specific code from core
      mptcp: pm: worker: split in-kernel and common tasks
      mptcp: pm: export mptcp_remote_address
      mptcp: pm: move generic helper at the top
      mptcp: pm: move generic PM helpers to pm.c
      mptcp: pm: split in-kernel PM specific code
      mptcp: pm: move Netlink PM helpers to pm_netlink.c

 net/mptcp/Makefile       |    2 +-
 net/mptcp/pm.c           |  644 +++++++++++----
 net/mptcp/pm_kernel.c    | 1410 +++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 1934 ++--------------------------------------------
 net/mptcp/pm_userspace.c |   11 +-
 net/mptcp/protocol.c     |    5 +-
 net/mptcp/protocol.h     |   36 +-
 7 files changed, 2029 insertions(+), 2013 deletions(-)
---
base-commit: 6b32949274eb9e32fe867ba9a8f8cb98587ecf36
change-id: 20250227-mptcp-pm-reorg-code-13227530bd05

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

