Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6D203712
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345604; cv=none; b=R+0k2oXJPQElFi9T8dkSRuUITwrOuSnGo6mB7T2bvCkWMsXmM2uCazaH9GLAxOcY49WtN2uF7BnQ2hiWBt2gtYufd98RkSChIEe00DCWbH0EgHXWEDeYYu0eIBAxQFzygoMklwNT1UbFAvVeKOfk4Pp44UFsQ//W3V2SPq8O5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345604; c=relaxed/simple;
	bh=uO1/rLSg5N9foCA9GJpXWQryuEWR3UegYX9XYKhKK0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXlWiw0nC8Phbzrz8z+g8LHecqAXo6BvdtlMTkBz4MoQNokQt9D1QHhOXc1phbZCy/lrS1FRLsYSWOpKggFdLcjaTcFeT/L5EpVBvKu1xcLHGLKWVB+8D3JjPjZKvvEgesI5clWgQTR3OgYpX8z0Z1sJIS9naMTkT/sy/PEuS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVtscH7t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVtscH7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBA4C4CED3;
	Mon, 16 Dec 2024 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345603;
	bh=uO1/rLSg5N9foCA9GJpXWQryuEWR3UegYX9XYKhKK0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HVtscH7tsTmjst2692Vh7a1lB2Bg/5KP6IZ/Q/Es74XWED2yHaAcE6qQXa8DlvGx2
	 5Io5vjQvzgEK3IfEMmjghuHsVke+4ZfCzjCV6SYVs1QD34OzivAi8j3IzSYrq6a3k8
	 dgE0yobHU3troDkrhOt1/CRHEfYREsq5nR+5TAIpgz5fHb+d5pfEMmeTg0eymeIPP7
	 cREnunHnEsMDbjJZatGSo8rmC45cf7FfKd+1M/lVgA8Xa8tmRoM8vllUOHSboxdJ9z
	 zZnbEAWoUT0k7mNwNNlj6TsCdjAaXPp/dMSwXmoFXplGeAxTtvx8b1UdYCxkqnC+or
	 s4bmqS6Yb7OWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Dec 2024 11:39:58 +0100
Subject: [PATCH mptcp-net v2 3/3] netlink: specs: mptcp: fix missing doc
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-mptcp-pm-nl-spec-doc-attr-v2-3-68807f55d42c@kernel.org>
References: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
In-Reply-To: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uO1/rLSg5N9foCA9GJpXWQryuEWR3UegYX9XYKhKK0E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnYAN/DibSBQohYKywj2YWGEYQoAC174im1FuzR
 HPtk7iKjv2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ADfwAKCRD2t4JPQmmg
 c8pSD/9HVLAD+DaZjUkhM4uoxLgxz/Y9e9CAzgKQst1gfdYAYKFV7mlfnRZrmIJ0GrfIUukXm7X
 y4x3tpTzUmwSvlp0inaieG7RtlVKvgjano83sxek6tKwbMsaN/Vp4dOoEBSDtk5scmPG8GVQk9M
 RmOlbq6jmlTa7jGFU/agTGszUWjYRXNfFXPnQcWDUXLebbQm/vnRn/17qJ51gGldRUKedTkwoc/
 FBASRlgAdRDo9nJt9Q9+Sci5Cxgg6THrKiduuJBblyE1b5BEos6rgYuXUb/+l19OgeYR+9f3dUH
 Jcxds9Gp/hVo5xtAI+Np/X959LkIx4rUbJikIEs+uLx3RKd+wO7GaG0FIJpZidA8ZbF9n26TWbF
 0LUPwU6N9ajhFFCNXzNs6bN/+RDCvkEGSYu89QdWgPhy45ONL2CV4SUUyiUpIunQUVzUTa2yLc8
 4aUm16KClUjCAHmJ+i8kmaJ9zyNkHWUZkAo2GMc6kcdAQLKKay8orI9vAMS/Bkb/NtQpjUjTbhH
 kVsCVUdUvyLD240MUeo1kwK0ZnD2Z/4rh543t2MVMbgfMxZzZ4QBckUfIYRHS2blaW+5KiFFPus
 kLBThNBuB4V+cAbCnRzUhpFIblCI/ArkOkcODZ8rzCORyLN3UxPwNheKE/bRds+6RSeMBIZZ4Fg
 exc//fm2drfjQMw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two operations didn't have a small description. It looks like something
that has been missed in the original commit introducing this file.

Replace the two 'todo' by a small and simple description: Create/Destroy
subflow.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 59087a23056510dfb939b702e231b6e97ae042c7..a9519ae77d38ce2af58de77c059ef22cd2e3f563 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -375,7 +375,7 @@ operations:
            - loc-id
     -
       name: subflow-create
-      doc: todo
+      doc: Create subflow
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -387,7 +387,7 @@ operations:
             - addr-remote
     -
       name: subflow-destroy
-      doc: todo
+      doc: Destroy subflow
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]

-- 
2.45.2

