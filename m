Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455C230998
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157162; cv=none; b=ogy51FIu9JfFDREMh/gjcGQY86Q4dPApQ3e5+QxBIH9BD5/C0h7jVMXixMMVEaBU+oTPKCVOCScwmr1VyEwXLKffnAm7gOV2tjNWDLOSNkb7p7IDcbY/YzsEP679h72vCBUVLpJrk1lnQk5+YEeS63Tj7BT+6JNaaMR0PuAmURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157162; c=relaxed/simple;
	bh=xBQau2dB3ZqMsch50kW/RVprbPHbSyvtjxRPMjGe6zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHpC9P7ZEDVQiVqvT8la/5o2qKHdACmayBzrXj++tQkXCvk19+P/MmqFdpCPKvDaQMQqIaqTI9RuBRrYNy3c5lJa64t7UWJy6qhuucQoU7XhTfAfsefui91ThiMkNdK6sA/FhGuwUpPbqEjoXITCxdZLMnroSpi0whok+xldwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7KIgsSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7KIgsSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB10C4CED3;
	Thu, 21 Nov 2024 02:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157161;
	bh=xBQau2dB3ZqMsch50kW/RVprbPHbSyvtjxRPMjGe6zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7KIgsSI5v0dU3j6Y1FNR/NMcdHmpcT1zmS4QQAfwJh78ZRmFvYUd2BlPsNwZ+4ia
	 9wvaIyG3h4VoUPtC2jLP+0Pmo8Okg0GW2rLlX2S2TPmNGomcar6RwMZAmZopBci0Z0
	 ZJ24e+mkb4IZQGyjhmo8WgUDJP6VJEvZmKNGoryaPC4BMiz7TVuSodi91Kc61DspWI
	 APwDUgg7so4fykCXIkSqGam1wTmJ/gIOOq4BxecnCkJoBTkdYUbVcwqo1ERje2JOoH
	 JeuhKobPPrAUTw8+TP9ZVdYuhXmhVbcmHa1S/wrgK/VqAvWbOsShgIAYj0zQq8f9Fs
	 D1tfeUmRrq5VA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/8] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Thu, 21 Nov 2024 10:45:42 +0800
Message-ID: <2dca04396fe589024c2f373d4531f0d1a50c7d98.1732153672.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Split get_subflow() interface into two: get_send() and get_retrans().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..41e6639253a4 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,9 +16,8 @@ void BPF_PROG(mptcp_sched_bkup_release, struct mptcp_sock *msk)
 {
 }
 
-SEC("struct_ops")
-int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+static int bpf_bkup_get_subflow(struct mptcp_sock *msk,
+				struct mptcp_sched_data *data)
 {
 	int nr = -1;
 
@@ -43,10 +42,25 @@ int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC("struct_ops")
+int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_bkup_get_subflow(msk, data);
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_bkup_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_bkup_get_subflow(msk, data);
+}
+
+SEC(".struct_ops.link")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
-	.get_subflow	= (void *)bpf_bkup_get_subflow,
+	.get_send	= (void *)bpf_bkup_get_send,
+	.get_retrans	= (void *)bpf_bkup_get_retrans,
 	.name		= "bpf_bkup",
 };
-- 
2.43.0

