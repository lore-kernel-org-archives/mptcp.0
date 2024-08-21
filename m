Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99B2B9B3
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208071; cv=none; b=H91LDZwOLYFLWLTk+pZcZFW6W1hb31oikilFG3PqBFx7uL6USO240Hw2kgEN3JtYEfBdUh7XjWbLgClPAnEbEx/JhFmUHfmV7zFIrZbhATlGU83CrpxO8yfurmYtOY7OcNP4Dk79UtrwGst9KYgsmVGRv7dunHVasSVAdhHVFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208071; c=relaxed/simple;
	bh=guD7pSC2rVTGV0QsSkal0xartsx/aFfOmFPOl4SPvZM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=hpT0MLXKTGDzrvHH1DgVof4+acTSuap4SwGL7T43v12LbQdUPsqj7A0m73iLTcFwzSd3/9YluIaKTf3xInXojV/ixV2zeuFS16Qs26NemOfWGkBLgtmEWxEfrv3DiqXosLVjfPvDx1o2AfTiYmDNvOecjpmGQ35sPEh6MexfGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=V0FhZ+cH; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="V0FhZ+cH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724207759;
	bh=hBaHG4goidSZc6tQBkSq1IMT7DA0lF+UvmNdzfVNKFQ=;
	h=From:To:Cc:Subject:Date;
	b=V0FhZ+cHdZ2xqEX2bVCASDL/VojMbXsKStEK9ZhUjO+pTYwRTBOP9Mih+NFbZxVeK
	 YAwJWPzs2RpOU4PeZAqrqpSyONTi7ZUImCGlqx29AsnlgOEpA6VysuXWmgjVRPMsCC
	 vwloEsP1uDCN/gh/QK7PtC2rCMqnkKTJKpOuGisU=
Received: from yangang-TM1701.. ([39.156.73.13])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8F9AE600; Wed, 21 Aug 2024 10:35:57 +0800
X-QQ-mid: xmsmtpt1724207757tpawc7ehg
Message-ID: <tencent_48C13AF02833651C8CEA9329191D76628207@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtOucJUIlHDMOgwBdJuBwhNDzUR1OO+wkqkZYELoRzVXsSRcL1yG
	 wk+F4QP3jrzfOvxenD/Vi4fGdKu1ZvJSTKFx+Xe07IXDr2AUqzmwXqkIMDua2sHBaHmXsYebvapU
	 UzUrsZntR/4xPS6Fe0OG1f5AYJLQP9+Zh+twuFgTaQCyJ5aoxkD9c2rBdUz0r8vFlYgIb9XIrWvK
	 SvRaBzweCJsbcCHXnnm4fdacn6XZRMusXt3HF3KGIHek8UJPGJ6SLL6MjusMaIkBd9vL9H34zM4t
	 Lhxp9g2AAdbjaEsi+Cyjacg/5ks4EClR/aHxY4O/ZE7kgHcGHxcV0/ynUcLeh6Elv8kzrgQMc1HU
	 Bz9vO7CfCrjse3MduxKhxr6eqQ2sh8J90bgyJ7HeXc29c/OXreMFR8+cJgNsADSUNoxbhHzbgSxw
	 wWClqdDNzVxRFEfwbhpfyVCCKGY/tHVHZvmI4KhuWuuFfTB5S187M8eMC+K90cHY0lUQrtH25lbs
	 bhtu1OfAQ0C8coo3laagch5zZwRS3g4plh848lsQ0yv8g4zFW09GC0Ak6GHpOUsZLDkZKk6FeVCt
	 ZrnPUzRfVB1OzgymmNsBj77AldotG6fSPXa8asFl8hVlYkSpYLZpziRR73HUACIBfVBJ1daE+Ihn
	 MsiNMpgVOnIXjSsRr2+/QR0XgsSWbQlwWN6qTqtXMNIrFJiIAoozsgJ6aNFH/WnKnBw0igtK+kzO
	 ent6FD/46g1/wt7PSn2taBcXUog+om2txTKUB2EKl9PTqZEsZraYJY594CSBjGl0JQYRf3nUSH6q
	 Ac3tkcsINET5cZbRq3Z+cVD6YJRvbrLWEx3zDKadEcd4Cqd1UwgNxnkPKbL0ULmBAUfM2Q/BLDvW
	 7k98N+ksiSzHMWzNiIBlbBnqvUHalSiQ3D5NDdTV7Pu0TfsWXXE3CYM3rcAcPmfBKT/oNNoXhpBe
	 IXM1vxvJdFKpw3FUrQ7uRR9NuSdmSY9aUFL21ua0F7rPt9L6FMQzaxuCxe1pGZ80OdHGZVMK8DWe
	 N9BssPEruu+w//A2/j28RXWRM2EoGPncrEafEpew==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Gang Yan <gang_yan@foxmail.com>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next] bpf: Allow error injection for update_socket_protocol
Date: Wed, 21 Aug 2024 10:35:52 +0800
X-OQ-MSGID: <20240821023552.606913-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

The "update_socket_protocol" interface is designed to empower user space
with the capability to customize and modify socket protocols leveraging
BPF methods. Currently, it has only granted the fmod_ret permission,
allowing for modifications to return values. We are extending the
permissions further by 'ALLOW_ERROR_INJECTION', thereby facilitating
the development of user-space programs with enhanced flexibility and
convenience.

When we attempt to modify the return value of "update_socket_protocol"
to "IPPROTO_MPTCP" using the below code based on the BCC tool:

'''
int kprobe__update_socket_protocol(void* ctx)
{
    ...
    bpf_override_return(ctx,IPPROTO_MPTCP);
    ...
}
'''

But an error occurs:

'''
ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
Traceback (most recent call last):
  File "/media/yangang/work/Code/BCC/test.py", line 27, in <module>
    b = BPF(text=prog)
        ^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 487, \
                  in __init__ self._trace_autoload()
  File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 1466, \
                  in _trace_autoload self.attach_kprobe(
  File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 855,\
                  in attach_kprobe
    raise Exception("Failed to attach BPF program %s to kprobe %s"
Exception: Failed to attach BPF program b'kprobe__update_socket_protocol' \
  to kprobe b'update_socket_protocol', it's not traceable \
  (either non-existing, inlined, or marked as "notrace")
'''

This patch can fix the issue.

Suggested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..63ce1caf75eb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1695,6 +1695,7 @@ __weak noinline int update_socket_protocol(int family, int type, int protocol)
 {
 	return protocol;
 }
+ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
 
 __bpf_hook_end();
 
-- 
2.43.0

