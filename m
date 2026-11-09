Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224889;
	b=3y+42dDj7H8juC0EhoU3R2OUhNaUypMbLWxT6yF6Vd99QstQNdgXBQB2SD01wFacWD71
	 DbFxsPZdHxyuolJPYJAxXxxGooaAVXU7nWcVHIU7RosWA7B/7MgjXxbSdg/s/eqTPMGFC
	 PbF+5mdkkEbWBKOyYAKKfB4+p0zYO7HlZmq/DO5tdNIo2+xrM1fsdfxFVRfZLkAKta3g3
	 GvtDfEw655+NErHBUrgjyIQ/oXjLTuW/lxf3KMVhVUK0AFr5fQ6JiTsY3aVMf2piFQo+0
	 S/G9vqUJAclwrfklgkby+6Rmi6Fr5u3CjLLM7f41YrA7aV41ASXcC/iP6VftBQcqrsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224889;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dLR3tt7szd0TGb4S6lGS4WgHmWKCFdUs6WqirA3PsmA=;
	b=rTZ4YH9cheaqO9l6JPK+nSO+VEUeuoTsxbN7IBfymiK+pURkgV94TrSaRX+D53FKUYNN
	 H7tzSUhvBiWAQTSa5s3FMUU2upTcOKekfiRorIA+N6tJKvrOmRWCwLYaAMk49dfmgENBh
	 7n6ZYh5BFXTbIJgRN+ta9T0RD6sp/T/nYgJAtwtRS/oaA5k7s/JeGR6Tx5mmo0TXnwRRl
	 IP/Q2ZkDM0zEtD04w6pXWMWit6Wr8oxNLuum6vDxoIdU9kEjmmGa4zPTtid6ap3Ypf3rO
	 GbA/yb3dGWOK90Xqry2cDCiCiBE+iVzqNJGIAphzWdbrTc9PN6QpXYW5Jz/fFqsXZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2YpDqpu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7A606A331;
	Mon,  9 Nov 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2YpDqpu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861661F0089F;
	Mon,  9 Nov 2026 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224888;
	bh=dLR3tt7szd0TGb4S6lGS4WgHmWKCFdUs6WqirA3PsmA=;
	h=From:Date:Subject:To:Cc;
	b=k2YpDqpunDxbXTKheHuhlfv2XOrJFFgY6jW1HZShoaqiqZUi8/zosif5k2yrb3yXd
	 qTsACoA5kCZop/JmGsEDY6XIy1ODzo+3kG2q4hx286F+TAsTyXja3+/H3PXX74eLf7
	 SmvukGAmFHi2iDsUea/ltdfCL8mWhVkeyE7nTULYI8KK+vvQpQQxiBBlwUQn8VYLlN
	 WIPVvh/3RAaC5I2gF+gLre4lzsoMCYR8gAMYBvnqPNN4VD+sb68je1Dn4ztdF6R/ub
	 H8pksf+QAmpbpbp3wN3TErRC2XoPbVC8y2CXaKFsdUVTOjCr9eYmZM1hP7y8noeQx0
	 Yrq3vcbNUr2kg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Nov 2026 12:47:26 +0100
Subject: [PATCH iproute2-net v2] mptcp: limits: fix JSON support
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
Message-Id: <20261109-mptcp-limits-json-v2-1-ad8d20051515@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwQ6CMBBEf8Xs2TWlKqAn/8NwKGWBRWibthAN4
 d8FvHuczLyZmSGQZwpwP8zgaeLA1qxCHg+gW2UaQq5WDVLINBHyhoOL2mHPA8eAXbAG61ToXJZ
 pntUKVs55qvm9dz6BnbdjJImGIhQ/N4xlRzputVu+5RCt/+wXpmSn/qxNCSaYKZ2ddaVKcb08X
 uQN9SfrGyiWZfkCSQgdXNMAAAA=
X-Change-ID: 20261029-mptcp-limits-json-f60c82b687fa
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zy7+Fbeo8gWBYR6XZE0iheb26AvJ8im34GrTrSSazQ8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI+bvq+J/HwzBUzSm/zzxHhfNE/R1d32wPG7WkB7aWXd
 Fes3vF7eUcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEnFYyMuzKXzA5cXnsW4by
 HJfrG1YKOrzI+eYWw9Q75cJjxmNJCd8ZfrNMzuls3y9cZDtrS5wf/4s5jetCWB2XtG3lrM6rcFp
 6kAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

print_mptcp_limit() was trying to open a JSON sub-object and closing it,
but no JSON object was actually created before.

Because of that, JSON support was not working with the MPTCP limits:

  $ ip -j -p mptcp limits show
  add_addr_accepted 0 subflows 2

Create a "plain" object before calling print_mptcp_limit: the MPTCP
limits are different from what is usually seen in IP commands. Indeed,
this object doesn't list multiple items with different attributes, but
only a bunch of attributes. With this _plain() helpers, an extra array
is not going to be added: it is not needed and doesn't make sense here.

After this modification, we now have:

  $ ip -j -p mptcp limits show
  {
      "add_addr_accepted": 0,
      "subflows": 2
  }

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Explain why _plain() is used here. (Stephen's LLM review)
- Add missing 'not' in the commit message. (Stephen's LLM review)
- (No code change.)
- Link to v1: https://patch.msgid.link/20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org
---
 ip/ipmptcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 02cf72ce..54976c08 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -446,7 +446,14 @@ static int mptcp_limit_get_set(int argc, char **argv, int cmd)
 
 	ret = 0;
 	if (do_get) {
+		/* This object is different from what is usually seen in IP
+		 * commands: it doesn't list multiple items with different
+		 * attributes, but only a bunch of attributes. Use _plain()
+		 * because an array is not needed and doesn't make sense here.
+		 */
+		new_json_obj_plain(json);
 		ret = print_mptcp_limit(answer, stdout);
+		delete_json_obj_plain();
 		free(answer);
 	}
 

---
base-commit: d95f66508b32fb2c51e70a9127dffd1db8623614
change-id: 20261029-mptcp-limits-json-f60c82b687fa

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

