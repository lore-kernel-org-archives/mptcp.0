Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05375817;
	Wed, 19 Jun 2024 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793677; cv=none; b=UQrLDcSHCMvc4ToXlbT/BL6o3aBORHptZpMM1iMnwhHwuy3bIThmvu83r8LCq6ObIa9RgcdZmnLB4RdNMkdv5fps0b3qT5OeAuUiyVeCYzOfq47rcE96q31gVtgM5lnSLt3kZWk+Gw8XA8XLnlpeTkb6srqzrgFX6BzTyJ/LCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793677; c=relaxed/simple;
	bh=1TmCdo+FO/zkEnVKnASxRL4HA4jV5ExbAC4KK+Cu0Oc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=D76OGM1Cs3xJvhmqN/oC0g4pN1Y3BG99ijjlMcB8pkxBdHA/GC0iWdl+OcTZr+8btprcIORpflpwVCZBPiKoT74p11oE1QGqIC9KoV7CVfPb+isEhUTpzGGl0yCPF8NBkROEIDgBov14qg7z5ZgSCn7opnKW6hxKbxJ+cUR6iRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vLWFtDEU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vLWFtDEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BB2C2BBFC;
	Wed, 19 Jun 2024 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718793676;
	bh=1TmCdo+FO/zkEnVKnASxRL4HA4jV5ExbAC4KK+Cu0Oc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=vLWFtDEUn/pFHG3/ipg+G9kxUwVKRd0d4D09RJCfeME9TbJc0is4QU8AO2IUylQIT
	 1o2boTLa+qG3gaHhHcznfu3HZ3sQ/OhrK9egW4bmy+i0+2MQxXNzU6jkEY5rokm0YP
	 5E17oQQzJEEX8aitcwvaPK1pHVCQN0hlU2n0RBHE=
Subject: Patch "mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,liyonglong@chinatelecom.cn,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 12:41:05 +0200
In-Reply-To: <20240618122511.640963-2-matttbe@kernel.org>
Message-ID: <2024061904-unpainted-vitamins-cc50@gregkh>
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

    mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-inc-rmaddr-mib-counter-once-per-rm_addr-id.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-52670-greg=kroah.com@vger.kernel.org Tue Jun 18 14:25:24 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Jun 2024 14:25:12 +0200
Subject: mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, YonglongLi <liyonglong@chinatelecom.cn>, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240618122511.640963-2-matttbe@kernel.org>

From: YonglongLi <liyonglong@chinatelecom.cn>

commit 6a09788c1a66e3d8b04b3b3e7618cc817bb60ae9 upstream.

The RmAddr MIB counter is supposed to be incremented once when a valid
RM_ADDR has been received. Before this patch, it could have been
incremented as many times as the number of subflows connected to the
linked address ID, so it could have been 0, 1 or more than 1.

The "RmSubflow" is incremented after a local operation. In this case,
it is normal to tied it with the number of subflows that have been
actually removed.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. A broadcast IP address is now used instead: the
client will not be able to create a subflow to this address. The
consequence is that when receiving the RM_ADDR with the ID attached to
this broadcast IP address, no subflow linked to this ID will be found.

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-2-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c because the commit 9f12e97bf16c ("mptcp:
  unify RM_ADDR and RM_SUBFLOW receiving"), and commit d0b698ca9a27
  ("mptcp: remove multi addresses in PM") are not in this version. To
  fix the issue, the incrementation should be done outside the loop: the
  same resolution has been applied here.
  The selftest modification has been dropped, because the modified test
  is not in this version. That's fine, we can test with selftests from a
  newer version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -427,10 +427,10 @@ void mptcp_pm_nl_rm_addr_received(struct
 		msk->pm.subflows--;
 		WRITE_ONCE(msk->pm.accept_addr, true);
 
-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
-
 		break;
 	}
+
+	__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
 }
 
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-pm-inc-rmaddr-mib-counter-once-per-rm_addr-id.patch
queue-5.10/mptcp-ensure-snd_una-is-properly-initialized-on-connect.patch
queue-5.10/mptcp-pm-update-add_addr-counters-after-connect.patch
