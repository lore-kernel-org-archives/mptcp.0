Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B01DFE29
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112528; cv=none; b=oYR/ka9UWEBN3tJFG2+O17gm1Z8xDKrhISiwjYzqwBrpeOuAXiF6PYea2Xd6YoqFw5fv5FOM0RbheLZXCVDwNW6t/dxZkVx6siWOEJTBggGE7Yey03fRanoSV36paRkua4aAj2VtdvTYDEoDZLYu8drhud0Omr5gblRdwBxRyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112528; c=relaxed/simple;
	bh=QmD39Ceev1u+dJicTicgfwcOoPEEiENmxWTYz3Y9QZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSdYz6xMj4UVIfpCJnLEW3dipii2qk/+t3asVOZ7TBgp5zxMPvDut56VjNOjTldyCGI5It+nBRC+mENiroOIf7QmqcqcYHJVSlT/j12QPPY5BWMGbvdWlk0x9YfreM0IUel/djL4GFEzHUonmc0AnViNgEqx5i0hHBL6lp9uhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjKDqb5p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjKDqb5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F23C4CED7;
	Fri, 13 Dec 2024 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112527;
	bh=QmD39Ceev1u+dJicTicgfwcOoPEEiENmxWTYz3Y9QZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RjKDqb5pn/RzyAaBOIY174EsdXj2R8bWQik8flfUrJzbnPV0wfiVn7eS3zh88Loi6
	 26nJaS+l1KwDRkzeGDyJCsvg/E1Evj6oPMY8cXjWHQiCHzPscemxs2dhqnqQsWh0Z5
	 P3hdz9fItfE9/VF16J/8Ru8bjUsbENGZj2PyQOI/7ZONt7YdPomtQ94KEYf9Ogz647
	 1NkT8NmXWg924fH/32vZYpJtYhcNDnfuEuGH7YbLlir4/D1vgtAynzx+DN6Ng3CRrk
	 ayWOT8G8EtCoG9FD+wi2xY8PqFD12k1ZdO7qeVBRSe21Ppn+M423KkGrP5DuhIhobK
	 ZWXSwGiV7wnBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 18:55:07 +0100
Subject: [PATCH mptcp-net 2/2] netlink: specs: mptcp: clearly mention
 attributes
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-mptcp-pm-nl-spec-doc-attr-v1-2-e43165c94e81@kernel.org>
References: <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
In-Reply-To: <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4276; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QmD39Ceev1u+dJicTicgfwcOoPEEiENmxWTYz3Y9QZM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXHUMBot0BW9cnh6sAExOipApXq/3cd+mtHj/3
 B+bbIJS6PeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1x1DAAKCRD2t4JPQmmg
 c8GTD/0cwU66n3F0dE8XJ9RoPv0ZEDHJClcnsVvYgRpYRqZfMV4qjN3nxfi5rORsCfwJ7TGu92D
 ji2Fei0kYasbQY4SWOVeZWLpu7mlwfCHoJxL4IRWvWvkZp2MApwb+z9lUQruiSuVe/HlZCmepFn
 /Pu8tkWcpZo7wHrqsrFDxnM0qz0oangrqdQ/LfoYTYPF3zhGD4pF7X+vOGvH2wnkANKGjW2T2rg
 vR+goCaciSqY2+I/pHIpnp9DfG46LyC00s3i9bnFKGM4RAbYEHrx9T/G8QTILVQAgOOvds5jGTQ
 QlS4uF74EBL0b5JgcDNXX+CK4cca5X6tVKuuNytqP+LumtCCU6oZ8PsXuSrwrQOFS90dw5mFgZm
 UJlNCwf7dUeOhv9ewit7iqLo7a/i+uZTi/CwVa1khV9tRiE1sq59Ut6Suz6tsSqwsLl8lloiFIN
 wDr+zo4nFq0LU3jnz5fnn25ay/HTQZ3aWzJxCMba0RYQNXziAQf/a+ZtjJwkUGXHXUDJTeko/ee
 SfwWpUJXne1bJXooJSReZrERvaYs2hGM7so+T1rbButOtYHT/Gg88Xx9CLuOvXdo3MTeQwNwsYH
 ZOnmrkhhPLVhhFpp0ewKPTW9TY2b/JMAwp/cf/bcJDHMeaoKgM1F+xE+MMjLvYkkcw/+N4PrGJ5
 YaER/I5s2nMalgg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The rendered version of the MPTCP events [1] looked strange, because the
whole content of the 'doc' was displayed in the same block.

It was then not clear that the first words, not even ended by a period,
were the attributes that are defined when such events are emitted. These
attributes have now been moved to the end, prefixed with 'The defined
attributes are' and ended with a period.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html#event-type [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fc0603f51665a6260fb4dc78bc641c4175a8577e..b9f6bd842eb394960b51fb5d9578f6cf2fa48814 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -23,66 +23,67 @@ definitions:
      -
       name: created
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
+        The defined attributes are token, family, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, server-side.
      -
       name: established
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
         A MPTCP connection is established (can start new subflows).
+        The defined attributes are token, family, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, server-side.
      -
       name: closed
       doc:
-        token
         A MPTCP connection has stopped.
+        The defined attribute is token.
      -
       name: announced
       value: 6
       doc:
-        token, rem_id, family, daddr4 | daddr6 [, dport]
         A new address has been announced by the peer.
+        The defined attributes are token, rem_id, family, daddr4 | daddr6
+        [, dport].
      -
       name: removed
       doc:
-        token, rem_id
         An address has been lost by the peer.
+        The defined attributes are token, rem_id.
      -
       name: sub-established
       value: 10
       doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
         A new subflow has been established. 'error' should not be set.
+        The defined attributes are token, family, loc_id, rem_id, saddr4 |
+        saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-closed
       doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
+        The defined attributes are token, family, loc_id, rem_id, saddr4 |
+        saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-priority
       value: 13
       doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
         The priority of a subflow has changed. 'error' should not be set.
+        The defined attributes are token, family, loc_id, rem_id, saddr4 |
+        saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
      -
       name: listener-created
       value: 15
       doc:
-        family, sport, saddr4 | saddr6
         A new PM listener is created.
+        The defined attributes are family, sport, saddr4 | saddr6.
      -
       name: listener-closed
       doc:
-        family, sport, saddr4 | saddr6
         A PM listener is closed.
+        The defined attributes are family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -

-- 
2.45.2

