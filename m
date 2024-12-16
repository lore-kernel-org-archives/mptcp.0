Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BD1C07D1
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345602; cv=none; b=gM7IsSDOujvq3gEAteAEagh6n7WlrCBfWKbKV8l4qJhbp1WVCUq4dMRQMvkKleagepk+85B+D8UXvM7lt503Zwv6F48bEzckpFy+XHlPhT6a4oQ/UyLOOYIQgX0oXIv9xKodJ8DWyEjd+aDGZyL/Jfc1n8A47rSJ8CiUC8hhVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345602; c=relaxed/simple;
	bh=Lfb2MKCFCGGczfJ3ZP7vkBTEp/Urx75PCUuN+KnAEwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSMBSHCveFZu5/zX+ns95iErrN8m/eoOCttH1YAUlRWcWNQ0iWmNaJ5hrIkSyOLGK7LJw94+TsbNgRnUd1hU3wdcKcH36Qs0ou9Va0/ju9edXHOLc214fZPkEAFsvJuAPC+K4r7sZN7lgDD3b8umI2DUDFJrlWY65I5WeRsMDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOSKxb4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOSKxb4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB0C4CED0;
	Mon, 16 Dec 2024 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345602;
	bh=Lfb2MKCFCGGczfJ3ZP7vkBTEp/Urx75PCUuN+KnAEwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EOSKxb4/siZQGBqFrg9HWsJ003w0iZFycqKEDvi8uxAVSsBvqjz2lkRjCb8LZdkuv
	 Ay7goO8I2/UC7P6hl2N15cqTdEm4Rg5+f7YwxsMOjm4HTAPOwlZv8d2yeGlEGEqwuC
	 pj0CwSDhsn+5ZquWHsmtU1WMjKihN4E7KAYZQJjhnw4/6DWPESLcxh8BfpOT5NGwmW
	 /rNZIdDwiEIcmPa9xZ8ic3GePMsbqsuYXQI2+7nqg8KEsxAowOuASXu9t1ST3bde95
	 RkqVP7pKbzuXFf4zhVOH+jN+ILvCeU/9odQ9Ob86LV5fZ3LPzE5c7rgR6zsvzS4m6t
	 xaOE93NdyL2Rw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Dec 2024 11:39:57 +0100
Subject: [PATCH mptcp-net v2 2/3] netlink: specs: mptcp: clearly mention
 attributes
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-mptcp-pm-nl-spec-doc-attr-v2-2-68807f55d42c@kernel.org>
References: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
In-Reply-To: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4492; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Lfb2MKCFCGGczfJ3ZP7vkBTEp/Urx75PCUuN+KnAEwo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnYAN/jYaIcFdlLnI8rmU38ihwvE6nkB5/znluN
 2wlwtDdkYiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ADfwAKCRD2t4JPQmmg
 cw/nD/9S2aOnFr6iHZhefd5n+fDVRWdBmgbTXihHz4QgUmcqaQt50vxOWCiNlEJAVXHrmtf9q++
 wGK5FHnYpyV6WeJA1GY7loz5zy4qtQnpTgSF4J1UWWMZozjfDR3iZg6q58x0Xei9IS2QjKstt+b
 9WXM3TtiKqbxEhl+J8AzdRIcUm2D/JfqAUnAKP4j57DxBsEhnxvs5PW1ScAMCl0UU4TvMzQhWzX
 HzzFikw7s1lwBwKDewxzLi69aep/7oC+lvy+POnMqsEyv4jcCnEf3jo3TTkWO7AmlTJaz9ND7pG
 IJZgiCLtYaNLyleEZ1zg0aAfufHMF+2JWA1T9dLTLIoQnc4xYB7bJwkJ2M5piCdV95fldzn8xUp
 5wp0IrfLKqDRssrMNcQUZYyUB5eOAogOcm2yLTqQ7J+wJacSpPTCeKEaZZ/IJSU0wTWw4fJge4N
 wfaPJA4Wy20MQM2SE7alskuWQK5C9wK6CXTy5pXA7AqNbcnwxnSsf2tn1WKymb2PyScnJEM1I+C
 jX/3pGkdHKjvWRHkiYJA7BAbxUf9bdKMDuCTT+5E2lw72AEayiCoMKW19+cj8FP0DivnuOQl1KN
 CK1QGzjNz/lKCEp6ap5bdmZtFjn2Qa6KDkH92o3FpRpWWpVs9OK58/xB9xM+jI+hMoenuhtqjdq
 hmdjGMopNxcceqA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The rendered version of the MPTCP events [1] looked strange, because the
whole content of the 'doc' was displayed in the same block.

It was then not clear that the first words, not even ended by a period,
were the attributes that are defined when such events are emitted. These
attributes have now been moved to the end, prefixed by 'Attributes:' and
ended with a period. Note that '>-' has been added after 'doc:' to allow
':' in the text below.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html#event-type [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- v2:
  - Patch 2: shorter prefix: "Attributes:" instead of "The defined
    attributes are" + ">-" to allow ":".
---
 Documentation/netlink/specs/mptcp_pm.yaml | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fc0603f51665a6260fb4dc78bc641c4175a8577e..59087a23056510dfb939b702e231b6e97ae042c7 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -22,67 +22,67 @@ definitions:
       doc: unused event
      -
       name: created
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
+      doc: >-
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: established
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
+      doc: >-
         A MPTCP connection is established (can start new subflows).
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: closed
-      doc:
-        token
+      doc: >-
         A MPTCP connection has stopped.
+        Attribute: token.
      -
       name: announced
       value: 6
-      doc:
-        token, rem_id, family, daddr4 | daddr6 [, dport]
+      doc: >-
         A new address has been announced by the peer.
+        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
      -
       name: removed
-      doc:
-        token, rem_id
+      doc: >-
         An address has been lost by the peer.
+        Attributes: token, rem_id.
      -
       name: sub-established
       value: 10
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A new subflow has been established. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-closed
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-priority
       value: 13
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         The priority of a subflow has changed. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: listener-created
       value: 15
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A new PM listener is created.
+        Attributes: family, sport, saddr4 | saddr6.
      -
       name: listener-closed
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A PM listener is closed.
+        Attributes: family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -

-- 
2.45.2

