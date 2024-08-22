Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043A1D130D
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304708; cv=none; b=FIQmd64XYmyWR4j39jVxHULJRr76DC07SFhMqXu8k1iAdKENlDE1nZRpkNe7fjqDgE5O4RgI6Pqg9pQL7sqd/wOJpDpWSNTk6CyD1C6k7ZR+u11ECVKxoesmeiXh8S020kTwM40GGGqQh0lA1FZUuXeR4rYAscRE5gzrUG4X+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304708; c=relaxed/simple;
	bh=NGpXsx7dgwIfGJMb97R57CZgwLbo52OS/ujeqqpq5Oc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZfyGqeQyFmmJ3NwXwhe7ibTlHzp8N+J9LTJc+c93QMXY288TRAiULx9zUnpMqsw6bf3MF7xrmwidRN2T67IRMJl4+0Q0XgPShB8J3+Pt71JSnfuaJXJtdB7vmwuREv96mz3iZ+3Q0ycvbAz43PP8fFJzmyWTYDib2Pp5tlBT5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wXiwEpZr; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wXiwEpZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724304639;
	bh=orGZxRP3EmbphZg4hF8C2M+U0CoOGrb/LiKV+L4HuA0=;
	h=From:To:Cc:Subject:Date;
	b=wXiwEpZr7ohLjakGQr+VDaU5KEq6BYpAe4pa+MhYJd05/yb6onD5RAxvUlKrq8XMV
	 WGrnv/qrhIozJg9jeN/W3VwC6B6NU8EoboSsHBdjkAuSKM08sBDdxd1SIOhfsJ12t4
	 FZZWY7eM+VpiSDPwKvN12zxoI9NZutu+6rw8XsuM=
Received: from yangang-TM1701.. ([39.156.73.13])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 7A4838B6; Thu, 22 Aug 2024 13:30:36 +0800
X-QQ-mid: xmsmtpt1724304636tpkzgv083
Message-ID: <tencent_CD94B9310E4F3464B4D83B0942EA0EA28409@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/a39KuHviw2sJI9kiFsHXuqkt5El4KajtS6wuvXyjfTWqqMyHNd
	 /SUd+GRnnPFvL7+VJ0nxczzKri0O3nnW0lh4mbWDj/4wR8ZR3GKoVFIRSqt5mlSPfp4tqu+Wt1T1
	 6FE5GzGGUVixLyNocpmqiRn+R81AbBgS0UShwlWF4B2v7P04oJ5F7679g3Wg0ileKlexNDwh0AzQ
	 BMc6K9EVKZqFsks13tdhLTORRkXqK6/NXH13G96wpEUMtcYUyyUkFGj2bhA+siY+aj7c8jr1Fg3y
	 S7N52eoqlQcIfYaP0h1QurQt/RPTTZhw61C96u29Oe3i8BolPxKOCh1XcFXYaOW0hKRvdjsePbT1
	 393VzNVgA68Mpjl0g59FH1C0SB48k1WcELNKceFDcK4x0gTG6kN7sgBishs6IR89M0snY8Z59lj5
	 P9VKKApfn4JZm1YFZIHRcbOPbeWa9s1Ys0Q8ODKMuZUBUQKr9jvHHoEFt+q7+V4s2lbuhaoNlMbI
	 DkPSsIvWZpFgn3wjg2El+3rjfVACd4uMEl70i/mOv0vpeeMHmsucnbfF5RoJNFohOh1Tw80l/ri5
	 7UageaFwlP7J6qbP97GXImKW4YjGMyKD+BdYj6q5oUmO8WYXKQAgRmebpC8iwcG2NZYdBhy5JCs7
	 vclbfautZDuqYKhgiu8z/+6UrxVDXd1JAPiexL1Dy4m+RteSV+3okBU5SVb5tHC2+xa7woAdXH8m
	 +lwr1WJgePgHuCK8GI66LRjzfBDjGsYnagRNdFVK/Y7oagfK2oGUN9VyxDmf7HSXa2egMTjDSv/z
	 4the8VdbBKXSvUCf6ps61ix7HzjsPOTICPGyeGuNmEcCwN2148iF04bRlNPSe5aAgT/GSH2alF+f
	 BwMmeQVQdBw6rsQ+6S18Y7CwqmVOk9Xwluwgd63zDEycYbZoJQQBGdlY44GrlDqHB8ajVJI8741v
	 cHsR1k9CA0pAchmb9QsMTGikBZTTq+fam+qioELVM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Gang Yan <gang_yan@foxmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gang Yan <yangang@kylinos.cn>,
	bpf@lists.linux.dev,
	mptcp@lists.linux.dev,
	netdev@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next] bpf: Allow error injection for update_socket_protocol
Date: Thu, 22 Aug 2024 13:30:24 +0800
X-OQ-MSGID: <20240822053028.916973-1-gang_yan@foxmail.com>
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
    bpf_override_return(ctx, IPPROTO_MPTCP);
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

