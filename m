Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63A1AB524
	for <mptcp@lists.linux.dev>; Thu,  3 Oct 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981017; cv=none; b=S+1/OF8PYr4CyxCufub13iz0nTdaBNb8XKSGXmjY/H7D1rA1fs77ojS4AHm20ZsUiUwuLW4MH4wTybnf1+Q6re8DZzt/4U4e3KvgZjMDpmTBhd0CLiiagcCA43fYUyBZ/4ftgQWctUdhz+cc6kIMW+ULj8LRUS3aBfZq9xb2LH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981017; c=relaxed/simple;
	bh=h0wRHcFcaT7CZCqTrblI6xcGJNedD0UIyQs0m//Qmco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qs920UVCqHTjdnckfrxVipJKBd732QmTJtKAaH0bKO+tDN9WzySE3eJ1efDeCwpiZMuHDDi45lhXgRoXFJHSb2ZVuTudcX3hebHLO/mwNvQgFMlHUdscaFjQNLf0f9R3hw9huEZlewpvZoTZ+OEuspgtMPB5kmvz0tf1Puw7plE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfCwaJje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfCwaJje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42299C4CEC5;
	Thu,  3 Oct 2024 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981017;
	bh=h0wRHcFcaT7CZCqTrblI6xcGJNedD0UIyQs0m//Qmco=;
	h=From:Date:Subject:To:Cc:From;
	b=nfCwaJjeEDMPTG4z12Fl1XUjNDQ/FkID7m4NWUpnw86847b0VB92634HgNr4ZjD1M
	 PMJrRbExCHHYJHx+rwcAjTmLENtua2bqBCMcDsAFYPZ+chGztd2jo4xX4quKjlXaEi
	 c+wQRbJAOuQE3Pozx7AUIzOdcWYyRwnFW+NeSDnQ0tjyBCYhFaINddIwLGGlJw0jlu
	 OVYbZ3rXCAvkhWar0KW25GK0b+4JO4VoYZXU8IOc13DzM7uNObMwiSh59Txtm9Kz4T
	 kpT6SX5Jj0bCZD8TM3239OorpSNB2fnmE+cvPdl+R1yOS562r3n4E61ZX/FkPI+S0H
	 V0xFSICKAoXIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 03 Oct 2024 20:43:25 +0200
Subject: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped after
 1st data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMzl/mYC/yWMSQqAMAwAvyI5G2hcQP2KeNCaaA7W0ooI4t8te
 hyYmRsiB+UIXXZD4FOj7i4B5RnYdXQLo86JoTBFRcaUuPnDelxWrKnBqSURW00kViAlPrDo9e1
 6+E3HBwzP8wJzlet6aQAAAA==
X-Change-ID: 20241003-mptcp-gh-518-b91ffc4b1fcf
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h0wRHcFcaT7CZCqTrblI6xcGJNedD0UIyQs0m//Qmco=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm/uXXEu6HvAbvRmPZyWBG1CoZVWyS39ceTDOa9
 om+Stp+rr+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZv7l1wAKCRD2t4JPQmmg
 c9cID/9rx1/2tUr/h67zbRwC8nkcXOv7rVsHNHq79/ZYZCcb4TF2MZI+GAhSOKv7HIp4as4QXzL
 6Y0J8Mkoah3UpSXWEUffpTjd+ID38ifmiw4RAD+B5Mk0cSvRseEpx4czTdBkdO+tXzF6dG3KcUY
 gxysPpUjtU2GUZcpKGjzaMQH9uPoDVlK6y6BiJ0/dgCIlk/1NG3l+Bc7uZBoLa4/kPXZHlpak22
 zbQkDCkJ6m59IOc8ksYhfId+dHeH75kBweC4j+dfq9Pq5loePsY8IhRUN3M1LnZhhVhRnzilErc
 Y0pAglYK3kR7CkT+gM8Q4FGrojcZrA9MpRUPwaosV/BuqdOYp7lrB62v0t9Pl0IaGqjqBQHG4OJ
 mSu08Df/ALkQzeps84Op2PFxUkfYz7/ItQcARwkLQDsgfg1dlaXaENAlJLHj3EJ3VGNK5L25pv9
 jtJgap9SD0Y8l2Gqed8HGYRHPVMFdBa0HvDmoqASpv2UwyZLIeJDkC8vIj/PUTSHRANequqGoxQ
 EtYYz5P0MCFm1UhUOgwnmua7BgUW2jVg7kyMOJwYBr2Pen6Ai0rImbQshdOEJkUhxuhsUx0vJ3w
 HBHueySGa0CTifSPhfKAaYZn1txwR7NmbhOIlD1KiInd57iXCt4knx8fEkySpcWWH9brUXKc1z+
 VM65FeS+PWkEdKA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As reported by Christoph [1], before this patch, an MPTCP connection was
wrongly reset when a host received a first data packet with MPTCP
options after the 3wHS, but got the next ones without.

According to the MPTCP v1 specs [2], a fallback should happen in this
case, because the host didn't receive a DATA_ACK from the other peer,
nor receive data for more than the initial window which implies a
DATA_ACK being received by the other peer.

The patch here re-uses the same logic as the one used in other places:
by looking at allow_infinite_fallback, which is disabled at the creation
of an additional subflow. It's not looking at the first DATA_ACK (or
implying one received from the other side) as suggested by the RFC, but
it is in continuation with what was already done, which is safer, and it
fixes the reported issue. The next step, looking at this first DATA_ACK,
is tracked in [4].

This patch has been validated using the following Packetdrill script:

   0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
  +0 bind(3, ..., ...) = 0
  +0 listen(3, 1) = 0

  // 3WHS is OK
  +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, wscale 6, mpcapable v1 flags[flag_h] nokey>
  +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
  +0.1 <  . 1:1(0) ack 1 win 2048                                              <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
  +0 accept(3, ..., ...) = 4

  // Data from the client with valid MPTCP options (no DATA_ACK: normal)
  +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 500, nop, nop>
  // From here, the MPTCP options will be dropped by a middlebox
  +0.0 >  . 1:1(0)     ack 501        <dss dack8=501 dll=0 nocs>

  +0.1 read(4, ..., 500) = 500
  +0   write(4, ..., 100) = 100

  // The server replies with data, still thinking MPTCP is being used
  +0.0 > P. 1:101(100)   ack 501          <dss dack8=501 dsn8=1 ssn=1 dll=100 nocs, nop, nop>
  // But the client already did a fallback to TCP, because the two previous packets have been received without MPTCP options
  +0.1 <  . 501:501(0)   ack 101 win 2048

  +0.0 < P. 501:601(100) ack 101 win 2048
  // The server should fallback to TCP, not reset: it didn't get a DATA_ACK, nor data for more than the initial window
  +0.0 >  . 101:101(0)   ack 601

Note that this script requires Packetdrill with MPTCP support, see [3].

Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on mapping errors")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
Link: https://github.com/multipath-tcp/packetdrill [3]
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Davide Caratti <dcaratti@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a1e28e1d8b4e39e14bc8f98164013d302d62595c..61482f8b425b5dde17a4f3272d04973ae5ec7849 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1282,7 +1282,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !READ_ONCE(subflow->fully_established);
+		return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)

---
base-commit: 8567c53ad205aa6e13f8d6c2739522907da3504a
change-id: 20241003-mptcp-gh-518-b91ffc4b1fcf

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

