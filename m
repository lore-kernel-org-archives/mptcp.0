Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EA1F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984516; cv=none; b=J/Tzv2uQu6FrTF4MqYK97KMvQpSB1VOpcT3WRB5y1N9aeCCEdhiYQuA736njFGke0lPsHhU3GHq9vk47M6RiihP5Rw6rdJLg78Y/iSFkXIKiJcrtts9ExNaqn9MwfT6SfIWJVhoH+xO97kxB/CsCEkdvGIA2a/rgiVCL7pyAy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984516; c=relaxed/simple;
	bh=F4MAuB6QFQmzQhtbpngs/2R1rQblHEYfrO/wmuPILXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbSe4EkhfJE20b8Z5XP7zzOZi8GvYK9SJusfo9eqXonIfdJDJUADH3H5clnXs/kQRizQxL8a6dTxL4Lv+gQS3siuzVGEaWOTRe2u0RQVeBayPRa3lr408LJ6OrkOOGVAGUy3Ln5NJVq0gKoctGYzcHbFBIBgiXZCVxY0CnvlBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9mYEtYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9mYEtYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D42C4AF09;
	Fri, 26 Jul 2024 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984516;
	bh=F4MAuB6QFQmzQhtbpngs/2R1rQblHEYfrO/wmuPILXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e9mYEtYLl0VXURKtKLfsxoSOyRKPNkxlXeL2fo0TGOXNR8mpUGM9Gsbvt8mmKDM+g
	 R3rD+ro/qvd29JIxQZK30aERkRYDqqHTKq81UGlTpnHW06JxKYJXm8bLIg6EAJorfp
	 2SWjkyf7sYVbcqGqeGpwdmOXD2WL6sVVwU4Ym56X6seR83K+AlA81dB1P0INfhkchU
	 +206V7NBjI0GiUhE8ORQWQKtV9d6vw6SjQGZEuAiDB2nyQiHGfQ5jO9KG889z985E6
	 chEdi7XTquzd5rdmv3aiPjpjPUv5DMF5rGnWhAx/OdRLffRJ9W6i6rv6MH756/l+da
	 kl951NsFRbuiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:42 +0200
Subject: [PATCH mptcp-iproute v3 7/7] ip: mptcp: 'id 0' is only for 'del'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-7-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=F4MAuB6QFQmzQhtbpngs/2R1rQblHEYfrO/wmuPILXg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6MqNgrGsLYQZq+Pmi9eCTj/prLNK8uT4QP
 S3NvdfMqHGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 cxVlEADlxEIlVGyO6r9tC7r+etJ3RYDhZddfnthpLC8HOT02Tym+qbNVSHIDwSziBt+DCA5JM63
 8iEa9eizV5V6Z2PSUgiNnvpD/xtcdJcgrVpG1pPlJ3JnDPWE1EXBzzUW+WtduI4Xaj75TLxtolD
 zcR42vt4E+43gYAHRmlArHsnairnIVxF+z+kD68eJY9i5mLZAO0zCh0jolGqWzSRzwnYVGgO6uf
 FlxCmSZI6CWhAMksgf57U9PTcp9KTF+ApmN7BpG9qTqtKh7RHor/95861iAiCbb/gdRfRob/+fN
 j8ed2Y3w9CIBM+F0aPkAVJyjLib0OwrgEwPZrPhzqvAGfOjHJ/ACVtm6djkVOZFacZ2oACDSyFs
 phV8JO0rxlASXsE6Z6aliYmt/cGHg46jtMASz+vLohVKb+lbV+ucjbwCprtiRMqS34Z8oNT4OJu
 Lqt5vuZ0i02hoaET3pbUnXSVB9DOp9YlqcVggxlSHpsC/ICKJtiKYNKe2kye+2dKe3C3zbq/Zou
 4POhxJJD4XSSebPSpulwNMRKC0HXycyISOwQ4blz4D3rF/e4q1rNEBTHS0UZJBDUkjOuuPqND40
 PCjeQ9fw6CZd7pxFPH5lGQqRAmHho1rXliPYK7E+9vsOZ2q+jOUXOW4fdI14MBqYs4Bj005s9Jo
 cgBnvADraW8P8lw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding an endpoint with 'id 0' is not allowed. In this case, the kernel
will ignore this 'id 0' and set another one.

Similarly, because there are no endpoints with this 'id 0', changing an
attribute for such endpoint will not be possible.

To avoid some confusions, it sounds better to clearly report an error
that the ID cannot be 0 in these cases.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 9847f95b..118bac4a 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -174,6 +174,8 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
 			invarg("invalid for non-zero id address\n", "ADDRESS");
 		else if (!id && !addr_set)
 			invarg("address is needed for deleting id 0 address\n", "ID");
+	} else if (id_set && !deling && !id) {
+		invarg("cannot be 0\n", "ID");
 	}
 
 	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))

-- 
2.45.2

