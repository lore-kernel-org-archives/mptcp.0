Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279870;
	b=Olg4CwiF1+yZWNhSGHpNYDyAzAbr0n1iocEfys8FgTfGNwk2+8QoqvdLF8pAmwtwPVXJ
	 0JtEXxBrRIukJ43QP/yhEXWRzlDxal0yYmjC0CjqDGY7CBDI/AZESmM1YHo+lsia2gind
	 EghrgluS+jfVRND4XZ9PHT9OBT+N8e/tibJi6e6Diya4Ik4QsPukFS04IgOroPXnALli/
	 G8ybt6UEeksbM4uKbg0NEOCzb+SmWNHvo9ww5YD5ZOJh5B0va5pNSmh176MF6VnRKmCAt
	 ftEGnSibIEJ05TDxv5zUJllSr5Uj2OQoYzagiiCyOsvU5F+cqo78O22NRgB7qcXDp0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279870;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=itUwZZapIXdc7/hwn/6nDnWonFyRdq9JsQZSrTDk8M8=;
	b=oKKQwYyXM163c2c8+VHsMzTvz9U8frXkoGiQuK5M/TneQdv+ya1NNufQq1Me2vVc20N5
	 CVN+atV4KKlM9EIjTR6ANcdyWa0V+lqCRWU/hChrPe0u/b2O8qvX4kpokFCRcCVRl5j9v
	 dMOrDBhmQJbnZPiSEGsQfypa6l3Z2Zylj4WvfpTxNvHCCBQB9lrEF3FrSVxZ4GzpqeV4A
	 NTgL1PGKePHnjXvKyWVhoe+n9gnseUpvMmMgX4q+4FYCQ9Pm0xVvH1/3DdrrS0bOg9Qbk
	 hfljyhFkfea078NU660DAYH0w0P5f7xUvt54mnVJ/Yu4o+QSBSgu1iEXqj6/5CHg1Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7F+UgoA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DD606A31C;
	Thu, 29 Oct 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7F+UgoA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEEB1F031E0;
	Thu, 29 Oct 2026 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279869;
	bh=itUwZZapIXdc7/hwn/6nDnWonFyRdq9JsQZSrTDk8M8=;
	h=From:Date:Subject:To:Cc;
	b=m7F+UgoAfPTCwpe5Uoc1DgtiDBLVZSiVyGI2F/gKR9s5EHcoUa1huMRbg1ZoDVjRL
	 O/zHFJXwM+Z9pcFp/A7yYgKBd7u7WMYbQA43ScDYKpxDMvYzgN+K3oDRFwLKzonu5t
	 nWojq24tSbUCOfwWeC7Nmub9D6rZyO3hOfEgPPfH8JzoKDevV1T8b+Iw4jv6/44MgB
	 wBAvueo5LCB5eb99rqVILG9w2IOHbni6o0+Co9yroI87Ty0EsQBLz3B9N3eSd5T+ez
	 MTABBRsKw/rcM/pHmHtioZ4nDYgYl+mIeKAePOlOAlYnjBeDuQkpNlr1OtjgwxHSFJ
	 hrZwwxId4BcNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 14:17:42 +0100
Subject: [PATCH iproute2-net] mptcp: limits: fix JSON support
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
Message-Id: <20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EK6h1j9inho40a32CRktyKU/
 t2ox2GY2UC5Ciucuw0qv0Qlpwb9oYPwGNOdUW6NgRz53tEJl2Kh4FMWMcVZc8LoXRho8sMxjtC
 6UjnK+/e8gJSaV2PCxAbXv9V1mjnYdwv7/gFnpJaVgwAAAA==
X-Change-ID: 20261029-mptcp-limits-json-f60c82b687fa
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1g1/RtU5VAReTyQgFSshKePKUFWF2IjxyVXrYAuG4RA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeu9dwP4s05pxySDjpgd2d21ce+s3nPPvhUEXr80XML
 xpaP9zz6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZgIbxnDX7kdq+bnax3i/xb9
 r8I+Y9GpLz+cJh473h5Xqp6rbS7y+C4jw951n4tMfmSohCTtPshvHhHWKHq8y9M7UPap478OV5N
 3HAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

print_mptcp_limit() was trying to open a JSON sub-object and closing it,
but no JSON object was actually created before.

Because of that, JSON support was working with the MPTCP limits:

  $ ip -j mptcp limits show
  add_addr_accepted 0 subflows 2

Create a plain object before calling print_mptcp_limit: an array is not
needed here because all limits have a different name.

After this modification, we now have:

  $ ip -j mptcp limits show | jq
  {
    "add_addr_accepted": 0,
    "subflows": 2
  }

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 02cf72ce..33906eb8 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -446,7 +446,9 @@ static int mptcp_limit_get_set(int argc, char **argv, int cmd)
 
 	ret = 0;
 	if (do_get) {
+		new_json_obj_plain(json);
 		ret = print_mptcp_limit(answer, stdout);
+		delete_json_obj_plain();
 		free(answer);
 	}
 

---
base-commit: d1341d07788e8148ce209107813861321a1fb690
change-id: 20261029-mptcp-limits-json-f60c82b687fa

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

