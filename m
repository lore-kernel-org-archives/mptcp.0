Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625A4E235C
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887239; cv=none; b=QBvVSPe8kRfdfDlAcXtkl//oNDIMY2kEVzmte3QuC7MX4gSwIg5ir7ZfCbfqNiTwrbdpUvotG13MpMwQXe+N6xTv3qeCMTm4vEmmy8UuDqDZKi0JakRkH5NQxqdqaVKIQkEpD4L/AgPxWrNtcNBElAjAeSe7khozEEjYtHcfhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887239; c=relaxed/simple;
	bh=WZwRe6WTDFuVR6WDg53CU/X9dSyElgLYPgOm2Vw7/YY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T97RcMQZKXmGDz4j3pEIugBm829Ue5o/50SKjoz+XVmeCTuIOLtKfD+krmVmdeV4MQ0viumRDi32lIawU5apO1djl93zHRXjWPJo8SdpACErpDdqp12a46BX+Ww/89sNY5eFfbT6D7Zwyd0LoDoRQlZN25Tb/q9C8b+dZ+1aWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IONdCtIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IONdCtIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9144D1F00A3A;
	Tue,  8 Sep 2026 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887238;
	bh=nE3DxnEyRX/Bg/9dOj64KigLTFpla9ben+INQTUUBXk=;
	h=From:Subject:Date:To:Cc;
	b=IONdCtIc4n9XuA6/Esp54PDrFJyEcDmRgfzoPXHNsBcU3lNG1S9aq6Q2/ACKk+GZW
	 tB7cfzDak5PY4FPxv/CLdGJx1OHMcpoF11VuEMdXwskPW5xEdiGTK+RVSetRG93LM6
	 enFlB+1yOpbWbwnpow3Njui0uYdOzx8ry9Q3Q4sjthYF6Ml0P6hRWUmOfN9OsNR3fL
	 12tULnzozYucphTxdb/r5UGqhXP3Q0Sjf9wyVYf4BK6iGe/wLhuS6IBdXWeoufe5lW
	 fTqHRmRVGqD6vND92q0ZNJs4WNnTRp+5BlBW3fYK7xBO60JTRpfWf3FT4MyvFhArEf
	 JMgqpgkVNrPEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: options: avoid printing uninit data
Date: Tue, 08 Sep 2026 19:07:10 +0200
Message-Id: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQqDMBAGX0X27EIU2kZfRTzk56vdQmNIYimI7
 960HodhZqeMJMg0NjslvCXLGip0bUPuYcICFl+ZetVf1aA0v2JxkddYOMF49rDbwl532tjh5tQ
 FVNOYcJfPfzvRWQQUmk+VN/uEK78tHccX5Bp2koMAAAA=
X-Change-ID: 20260908-mptcp-opt-read-debug-d818ab97c05e
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WZwRe6WTDFuVR6WDg53CU/X9dSyElgLYPgOm2Vw7/YY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWOBz+tTX+ldPhnvzg/RZpqnMEV26azspqfPlgMXdrm
 Hez3HzRjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMyGD47/fb93VIT4Nv8In5
 kxhMzp91ZFMRm7OKRffPlH8PDz62cmf4K/OuJUc74dKUjcd+W3oLe4ReKjlXNXefdafgxf8PU2K
 2swAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When parsing the MPTCP suboptions, some pr_debug() might read and print
uninit values.

That's mostly harmless, but that's also confusing. Fixing that also
avoids some tools to complain about accessing unint data.

So read these fields only if they have been set.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

 net/mptcp/options.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---
base-commit: a59eb98e30b7db5fa1cc7cd5343ad387bced3ae0
change-id: 20260908-mptcp-opt-read-debug-d818ab97c05e

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

