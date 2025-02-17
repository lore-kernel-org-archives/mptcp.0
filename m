Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2073D68
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781480; cv=none; b=H2wnX7ETCzKLfCF8PVPgnTFZjwxw97sMS9R4TVrXJ5YtLjiGVLViMrsruZgkFqRwfBHWCnxJSvBeBdP7Zjk9vhXOXynGflAPKyJm20lwnvbnYDAUclUagHFfxYzeEV3GfrWh8CLbOlhEJHAj4YbjubNzORdMhWAEhTb8OPGYXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781480; c=relaxed/simple;
	bh=JHeqj+JdMktcSEHNKttFrFlRMjFHBs9B0aCSjSWyx3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NphTO3RnWzzYtXCBa/Wa99IZQYF+IOEDZeFHXdAtA/0I0+zH99pZOaHW1m2PoaPt9U4DIBtmUi0WlWoYdYwkPHOsC+awXxVWkxWzdWj0YEoOVMuIzAaymS3il5v4RemMYt1Pdrn5KxRnDVbBWpvsd6V/UQ0j9HK2BfLs2t/UIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZr+uFnH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZr+uFnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09660C4CEE2;
	Mon, 17 Feb 2025 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739781479;
	bh=JHeqj+JdMktcSEHNKttFrFlRMjFHBs9B0aCSjSWyx3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qZr+uFnHLho+PAJ3i5a8Loj9ZccUFdQd37j6mVI/oEDqKbjDUybqqzYJyfhTvgZRf
	 RVrjZSfWGTeYDK9vlcTF3W1RZAxTpdwdRbugDhw/fkZaJAvYT9SiWUjpSO7DHuV5jb
	 td+92C12m22RoPgxTlO9uMWxPxqKbVGy+Vo1zPnt9sdhewlKCHo0hhRxHJyWfSUx9r
	 n52uqsWlWnvUU25i6UUtNUPftVTtslVVB0YwYN83FODuHAfWxC9UPtrVH4dM53z92D
	 kAwEVCviSzfuUzFBC/FQqQNd8a5ycoN09KBIShnTDmFDjV+0CuDz5L4rH0XWW4eZxb
	 AwOeA1GabcI7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 17 Feb 2025 09:37:41 +0100
Subject: [PATCH mptcp-net 1/3] mptcp: reset when MPTCP opts are dropped
 after join
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mptcp-dss-drop-mpj-v1-1-d671d6b9a153@kernel.org>
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JHeqj+JdMktcSEHNKttFrFlRMjFHBs9B0aCSjSWyx3Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnsvVkIpZKsWwEMzwSISN7Tkrcv7DsIOczP9lva
 rHqPikOQg+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7L1ZAAKCRD2t4JPQmmg
 cy3cD/4jhSkgCTbPrASRfwuZyk5tjicplAfBmuP2L0m2eWR4r4KoQlzf+7AWIGMIhRoDux5plDs
 kA69p4E8S+cJ6cR2U9LDj/t98TUp4h30jeRLGPAS1VYJ7qR+bBXPofS4UqD/wJctNg9pGLoxbP1
 m94CXYpGJR4a2IorCwvkXRtAHs7jhghsohAqngB17i5mXrmHI/lUsUq0ZlXbR8EuQoJeHVuuqoN
 jr67yF11MOxOh0t7ac8UOWPuRhXlcYwDlrPf0qgBYGz15rJ5/SNtheTt3pXD1RbKrilms+juW2+
 j5jcOuhbiUOBu0QrXQqbfO5IEd1fYW9iI5PYONkk3aDQ9BhdGaErHRU4H4yuEd3HYFNborSX3Ti
 tBFblsiZCthkyfrOltsl+4EjUMTALfJ7LREOpp2KqPFfs3l6TToSwh/Y1nlmqVstmYXlzQPzPzh
 X9lki7O8xfE/vcCRC+2FYJLUglUoNN1XDTCxZ90bznMps7w6c+fmx3Eq4ksanpzayRzp8ayf2yd
 Z/Z7SLOzzX/R0VosboDGNaZpJF1DHZB6mDa/UOYKCixV70C26fncripSpr67SjLWZ/D4Ughul6Y
 tqe+mSNxImPWR9UIZ/3R1ROLqgHaXwuOm4AAgz8TXKZf9dwS9tR5xUbw+A/8cu5+Yu2vT9JLCHE
 mE4hcMYIQyQGD8w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, if the checksum was not used, the subflow was only
reset if map_data_len was != 0. If there were no MPTCP options or an
invalid mapping, map_data_len was not set to the data len, and then the
subflow was not reset as it should have been, leaving the MPTCP
connection in a wrong fallback mode.

This map_data_len condition has been introduced to handle the reception
of the infinite mapping. So instead, a new dedicated mapping error is
now returned (infinite), and this special case is properly handled: the
exception is only applied to this case now, and not other ones by
mistake.

While at it, no need to set map_data_len to 0 as it will be set to
skb->len just after, at the end of subflow_check_data_avail().

Fixes: f8d4bcacff3b ("mptcp: infinite mapping receiving")
Reported-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d2caffa56bdd98f5fd9ef07fdcb3610ea186b848..6ec03580ccec12fb50fc3aacf3d22413647b32b5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -969,6 +969,7 @@ enum mapping_status {
 	MAPPING_DATA_FIN,
 	MAPPING_DUMMY,
 	MAPPING_BAD_CSUM,
+	MAPPING_INFINITE,
 	MAPPING_NODSS
 };
 
@@ -1139,8 +1140,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		subflow->map_data_len = 0;
-		return MAPPING_INVALID;
+		return MAPPING_INFINITE;
 	}
 
 	if (mpext->data_fin == 1) {
@@ -1357,7 +1357,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
-			     status == MAPPING_BAD_CSUM || status == MAPPING_NODSS))
+			     status == MAPPING_BAD_CSUM || status == MAPPING_INFINITE ||
+			     status == MAPPING_NODSS))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1405,7 +1406,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && subflow->map_data_len) {
+		if (!subflow_can_fallback(subflow) && status != MAPPING_INFINITE) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */

-- 
2.47.1

