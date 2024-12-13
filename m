Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146701E25F8
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112527; cv=none; b=bWECsggyJ9tHnAo2fsQH9B7UBvFL++K7Gj4gNIisCdbAQH60JYyhSUhZCHH4Z9W2xc4/K6eLZctWROABtLx/VAH1Kkf/90+E7viki5baaP76LvWvboKCrqYoeSekuJ2HDkPUCN5NZzL3VEii0eqdJOtYgA1zJnqMc9Os5ks1POM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112527; c=relaxed/simple;
	bh=O/D64pGe1iiy36ZlbHg3yMY/6TUaY5kCdmHow8CxxCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P8PTDjU5jMt1ZwxB+nb1fJfcxFD6wC576TlvDiedJBDwlB9eVUnkcjAkQWhkfmZLENQe92e4xatgzvq366Vfumt/I0txIpYLjpsYti74ulws3gEb+qDPvHoM4bofpTPh+S7Xznm0+CmfUplDIMFoyBtgmBKKxC9/LOLoYiQxxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MogUuI30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MogUuI30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5CDC4CED0;
	Fri, 13 Dec 2024 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112525;
	bh=O/D64pGe1iiy36ZlbHg3yMY/6TUaY5kCdmHow8CxxCA=;
	h=From:Subject:Date:To:Cc:From;
	b=MogUuI30ODINFN+cWtJF3jDVh7pFW9Av3LtdTb1F2ztpC/zE8DUx6iGiDaE2GuWF2
	 tdmEKFDcFeX/5tKGOzPYZVxR5Gn/Ej1t8T1FJfKVhphNpO/TF84Mv7mRUOydPN+Iyd
	 S6Lg+BWpxxiIjpdjdM2yOle7h0nV8depNZR8PwLmkn6wHtEMh1Zdi5AgyfhQsOfXgC
	 gk2baaW182MYR70uWX02VtnnZpoV6/HK5x4IbFOy7ApfEeWrNcm/DjqxcybR15Cn2H
	 ugI3GqseNEo6gtJR6Lsbdkrd0zmnigIjKkkekyoAgJTv3jD7gY42soR8ov53Hhca5w
	 rwET4LH/IBePA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] netlink: specs: mptcp: events: missing and
 clearer attr
Date: Fri, 13 Dec 2024 18:55:05 +0100
Message-Id: <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPl0XGcC/yXMQQqDMBBA0avIrB1oEkltryJdyDhpBzQOSSiCe
 HeDLv/i/R0yJ+EM72aHxH/JssYapm2AfmP8MspUG+zDdsYah4sWUtQF44xZmXBaCcdSEnrviJ6
 vvnMUoHpNHGS73gPcLHKBz3GcQDA343YAAAA=
X-Change-ID: 20241213-mptcp-pm-nl-spec-doc-attr-663cc79843cf
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O/D64pGe1iiy36ZlbHg3yMY/6TUaY5kCdmHow8CxxCA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXHUMteu2spzPEQJm/YsfjOZYwb4YrHu/e4gdl
 D0kq2qExwuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1x1DAAKCRD2t4JPQmmg
 czApEACbCrO3wY91BJnifiMrno3vRvdz3ne2zD3p1DGNk9DgKsh5AyLhA1se0N7Psl26TJ2b2wz
 ynxZ6XtLYSwhKkBK04L9x6OBoWIneY31ZQySi0a/yyj2Aw+dVQieGD6XWNPIKMc1Pjup6uaH4JW
 hZin6TLfDJMVdjh12ZkqwSTSn5dAOlj8AG013XwHsSSAxy6IAuTMXQbIl/z6fbW++GkgLd4VoHH
 HL+5uSyjI6bZGi0AdxPi9pTrEq70qXshAZYoFwI0nWlxfOCvTk2waYjxTQP4W4zk1I0pLVEjRLl
 m0WOdPLsk2gxfydSyHCek25aMFwTX9ny9i0c4F8DFwpWmPApwQ5BQm4S13J+EdCBrmlL5pMhXfz
 QC1RQWQNyeyOleLrVSt3eJRdY3kDGXIeYI3LsP2nGIoDMh8C6lmRdlxWEhMhVxm9umKCr2WnPEy
 LHy99cZKNStZWIHGuH0t0hCd6QoDcCQAIXDSUzGaCqKsyFBAiyyMO7VAk2NdUx9/7sC22/FwpGZ
 MYCMMwpHy4V6Vxau+tBAyrnDMbJ6kOcJbDCAUjXGDvWyHJXpiCcVi3Pd6h8i5vnXIM0DaPxPzCp
 3eU4ZCng/dvuA08UHVmf46PadckgkaMiG9bhm2taYvLus0ytVpg2EyyWu0jI7JDrxJY7Z941VOD
 CksLtQEsTqMO+VA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two small fixes for the documentation:

- The 'server-side' attribute was missing for two events

- Attributes were written at the beginning, but without explaining what
  they were.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      netlink: specs: mptcp: add missing 'server-side' attr
      netlink: specs: mptcp: clearly mention attributes

 Documentation/netlink/specs/mptcp_pm.yaml | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)
---
base-commit: abd143d0ceebde7465127242f5eeef1e9ea4e253
change-id: 20241213-mptcp-pm-nl-spec-doc-attr-663cc79843cf

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

