Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254144;
	b=L+2RPoTLfcZwMOP7XnNKqzbIRtHfReTR2lP2KVPJuAKP9c7f8cwOVFacvfaFDlGVUjb9
	 h8ax8IRmZpzKIHXsc12+UWp7Y+6GaABi/KelfV8KwRfdg+mEHwzBcZONGXa9G11FbOb62
	 63Buxw21pwotemaEqACbVNp3+LudMJ+5MzLwENYei3njcSFw6S7cEuIM81OceF0vLodhB
	 M2NMUfntXxeBTtOiySfpjNZYbgMZANKDeTctVagIAzjL52TK8ojIpghh7jD0UvZMeJ+7u
	 pbWVZeZ0kWyk99OGqwDhiXEc7N+2ofRKbLciRzLOWor05uwAtJfM8v3a4WYPAjzq1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254144;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cr4CNsbsVoztQq7JO0OWsEvUzbN7PEmSYtrgGym3LyU=;
	b=T1zQR5CHAXSZ02gPwqv074o/VHWsMuLrjFjNe6GP6BIAY7HaLq6+F+zOmzv2QhDKHQYR
	 2D44rq49Mtc/rIlDTuz2ltbSIADov1JzDMk9rLxYb0pNbl0H2Oied93OPMVQjDOsvRvPY
	 g9eIP1s2TnkmF160Lr1zRQMOmO8VrjfJgz76uJ7/GhrkM/lrJdnXFl/aZyxC2hKLrCWey
	 sp4s0dP5hLlC97n4dKdefzbWXNp/1AN3243KCrk/iOpzWHnAcJmMMQKXyiwIKee+xpsG7
	 mwndIuED7KiZ7jyWHLocyGgvEQuTk/Cd69rJDm/yQUqsNeWu/ss9XH/Sp8om6ChgRBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVd4rjbC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78208606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVd4rjbC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C39A1F000C0;
	Sat, 21 Nov 2026 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254144;
	bh=cr4CNsbsVoztQq7JO0OWsEvUzbN7PEmSYtrgGym3LyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HVd4rjbCCyXoS+ezdImrxgO54guvA8dcX+Vgg2jBCtYXpI9fCcGWI+BTHMPhrx97U
	 Ws04xLfI4ntezC0QRfPm1a/ElexPxA0/zpNGzvkMA+2KwwnPAR8s94WfUGHn2YtDRr
	 pTmvMQk+gEx1QZxL52bDRbY6H9xPJ9nl4F5fCoLlBguziJPWYfQAVapN5UgHzYC3ML
	 f/xYKoHIlIVQFoc1bKksGcG/9iOpF7mh+7MuJ13YSxrEp2JnY2Vo9SNBAbpeBsboQP
	 LvoTOuvtSIV78kKhNj8hz6P5DU3+NkLPdJA4rcO9U9DQ5VERm5FPH0zKga7BVys36R
	 YkiE7xD0hRKhA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:03 +0100
Subject: [PATCH mptcp-net v2 05/62] mptcp: pm: don't drop an RM_ADDR behind
 a pending one
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-5-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2967; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VWdDK5KC2XQ0B/Gz98UUdDiaS7ljfPigv0yw2cJSFtU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ033Wf97xVornPGfVFUWrH/Mt9WJnFwRp3VxtXhNgs
 lNiKpNSRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETaLzAyPNj7+PiWC20fpu46
 +HXd7j8n8hjy7LuYJqpvtOaeLvnUagsjQ6/+z1SR/Zce6b9xOfff7om+ZPO6P5vfpRZvYu2atut
 IDSsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

There is room for one received list of address ids.  An RM_ADDR that
arrives before the worker has taken the previous one is counted as
RmAddrDrop and forgotten, although the netlink events for its ids have
been sent already.  Two options follow each other at once if, for
instance, the path manager in user space of the peer removes two of its
addresses.  The subflows to the second address stay.

Add the new ids to the pending list.  Only the ids that do not fit in
the list of MPTCP_RM_IDS_MAX ids are dropped, and the RM_ADDR is then
counted as RmAddrDrop.  The netlink events are not sent for the
dropped ids, and they are sent before the worker can act on the others.

This issue has been found with the help of an LLM. It has not been
reproduced: the second RM_ADDR has to be processed before the PM worker
gets to the first one, a window that a Packetdrill script cannot
target. This fix is based on code inspection only, which is acceptable
here: the issue is clear from the code, and the fix is simple.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Commit message: only the ids that do not fit are dropped + how the
  issue was found, and why it is fine without a reproducer. No netlink
  event for the dropped ids. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: no netlink event for the dropped ids (Clashiko), but still for the
    next pending ones (Sashiko)

Note (Clashiko on v1): as before, an event is sent for each id of each
received RM_ADDR, even if this id is already pending.
---
 net/mptcp/pm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cdc8bab0eaf8..f1f4b13c5459 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -843,17 +843,30 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	bool drop = false;
 	u8 i;
 
 	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
 
-	for (i = 0; i < rm_list->nr; i++)
-		mptcp_event_addr_removed(msk, rm_list->ids[i]);
-
 	spin_lock_bh(&pm->lock);
 	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
-		pm->rm_list_rx = *rm_list;
-	else
+		pm->rm_list_rx.nr = 0;
+
+	/* the worker may not have got to the previous RM_ADDR yet */
+	for (i = 0; i < rm_list->nr; i++) {
+		u8 id = rm_list->ids[i];
+
+		if (!memchr(pm->rm_list_rx.ids, id, pm->rm_list_rx.nr)) {
+			if (pm->rm_list_rx.nr == MPTCP_RM_IDS_MAX) {
+				drop = true;
+				continue;
+			}
+			pm->rm_list_rx.ids[pm->rm_list_rx.nr++] = id;
+		}
+		/* not for the dropped ids, and before the worker acts */
+		mptcp_event_addr_removed(msk, id);
+	}
+	if (drop)
 		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_RMADDRDROP);
 	spin_unlock_bh(&pm->lock);
 }

-- 
2.55.0

