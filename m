Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487962;
	b=Fhfc/oH5SXe9yHt34hWOA0KX0qNeBbrVWCWWrDxiY05Lq1vf1XrrUBSusRqM0GezGBa2
	 NJdWDlBFgYyz+Pk3PAAJz+RkzAYlt9ULd7KiWpGB7QqfPm7kjl4tdWwNBr0Yc1PaS5atU
	 nodNVdqpkKoy4o1rD24KkvvMXnvo7qy1blNY04Dq3x/cnFDeT8UAAqstDacsJt9JAJuGJ
	 Zy92Gru3K74npcnCBZBehR0TgY0VS7cMnVCUujL5uW5vVLUYtLpsCDWpoUBIGxa1eaeFZ
	 gg7vMcHT5fFIv8Fes+2AuctQqzih/+2p9u7jpUBtFFiMn47svej31exrVQpjN3sMz2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487962;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=zERbofYw8/MQs4m2Z97sLUq0t8UMU/kOMROzADV/pVQ=;
	b=VjlvSvJ7vhWiuCLj0n5QBqGye1J/jjcEVuOhWnvaxgngJPvlM//4R7BcSRKiNPv5Byoh
	 KHdYpOV2teKj7vxNnR/5tCoagu+U6jlWSoYBq/c7fOCbaanrvXuROvt9MP4lI4Y0/nMGd
	 SrMkiPVlD0P5XHMBJeoibuMgp8xfjkkKAg2F6dsTKpjg1Ftb5nQi++gz8qNWLiayA6MHc
	 UxpjZ/pm59fhy+J5YsCmJvZLSCBML6CW6eCncXZGpSr/3ErmSD+Dq38MrCXDqzFAH6otD
	 C+Ijue85Ry86sD6oIdc0tbRDgcJ3CvBsQiPmW01dJPDvapJincBJocsGfwf8ZZ5vPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kxTdaM8O;
	arc=none smtp.remote-ip=203.205.221.149
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF787606A323
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF787606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kxTdaM8O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794487952; bh=zERbofYw8/MQs4m2Z97sLUq0t8UMU/kOMROzADV/pVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=kxTdaM8OxXNWRv5c1tVA3Gb6kIa4rdauGdfFJki/6BWajxAQce42ns0gVMTxOJTbX
	 jfjXekde6ctI/DI7FBKgtg4LVuvXbLwUpWBVrPJQ4gLZLEH4Qn1D1+AZ97xO59y8n3
	 GmHwrWtkQxMIRgjw7JoYmKK+mliMwAzFx9CRbfFQ=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:e498:8f16:a485:ceef])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D1C80E0B; Thu, 12 Nov 2026 20:52:28 +0800
X-QQ-mid: xmsmtpt1794487948tku1bgn3k
Message-ID: <tencent_EB38EF4908C9FDCB369DAA2CE362CB5E8305@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahMxe7Nis9QgSc5JxEKESr4AuDxdFrZ/QYTDiYS9ysjDE1CnnLKM
	 0rt3fNC31x4iIKHmDwx8FmDTUC4mSfmxvZKo+8Ssa6iAho4UM93ZmHJEE3pQ/BXbL/sGTKg/byPn
	 67v9lzZthf80XZfrRY6NvaAq5bG9J1dn/dKa6h4z0tiL0OnV5Y/RdbTfLFoHdJiqJfCjEnoVbf3l
	 O+Jgc+kNBPdp9dGyZLu0d5FEXPH5w7CltAjA7Lh40h99giR1kHDO6UKfzAQYQn34GyM4U/mshvsD
	 gpiiWv4TZPU3gYvYSUaUis7ZzHtZQdD4846JB2yW479YgHuYIhUY/AbADeV1t4V9KpHlQJDsM9vU
	 6Md0N7YwD9riXJdEMHxdXm80Xxb/FZBe++IlSWom8PIWV48b9r5bst/diW/Qdk+rFP9w+AloLAQM
	 Jcob0yapAm4EoRSutkQKH9ZqMp4FiKHaGPQ3r1ovr0D72u7KpS6/vCVYJ6Znz6D+tDf1/NlGHd3K
	 C0JKB2HCT5WIwMvUOfyndYUTck7rZm7zlZpb9B31OAWkqV/9eydsH/mgKsaOSGlw3VxB0xVj8i5u
	 DQJTcYLGw36edjA0F/41wRHs77eRDaM5ZxkV3ZFvRelng6PAHIHW7PGUORDLlwb1DjWDFzKIARJd
	 MMpvJw36pc5qbZkNqHxjP8ACX3/01W449xcZwWLIEIPp5coeJ8RO72xAnfnvQc0iZedOnr6VfN5D
	 zoetjpNPARW9HDVnfWnqBx8AT8F+sfHB/SJQYA4q5ry7vuKpHRSC9TCswKoh+oukiF24UandgOAN
	 uVJrK4dAdJ7WYrpcEZqIkh7eo8BKiJR1eEA0UKpb7X64p1E06bz77w256YYn4lCCXakcD/s5kRjr
	 0qwf0Er3utPTjXuCSG/bTwr5/OXvCRHveckHBcOeFw3KxC2nC2DsUyH+BuMHxs+IEFA7gFlWb4LK
	 LFjSu7GYk5Rnasd64nVCpruFtfhgdQ9+K2A0sCvXmwWxBWzOjqTIRBcwtYNrtcTHOb7j2qKS4RpO
	 RPuYy/lwn/JdrYJKzosgPq4dT2585zELl4mfgi5iqPLsfW/LboBK8F8uPWOqQDNTYkpogKsnrmBD
	 t8WEnSGKUtblBH77f9w0rqvKSwcxbAKZRjdmjfpx26vPeVqcM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: mptcp: take token lookup references with
 acquire ordering
In-Reply-To: <20261112124547.193812-2-2122295973@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
 <20261112124547.193812-2-2122295973@qq.com>
X-OQ-MSGID: <179448794830.196117.14284634941387773647@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi,

Thanks for the automated review.  Here is the missing information for the
series.

How it was found: manual code inspection, not a runtime report.  While
looking at net/ lockless lookups right after 5b5d8f351dd9 landed, I
enumerated every refcount_inc_not_zero() call site in net/ (101 of them)
and classified each one by whether the reference is taken only to keep
the object alive, or whether object state is re-validated after the
acquisition.  mptcp_token_get_sock() and mptcp_token_iter_next() are in
the second group: they re-read msk->token and sock_net(sk) after the
increment, and mptcp_token_destroy() unlinks the socket and then does
WRITE_ONCE(msk->token, 0), so the re-validation is the only thing that
rejects a socket whose token has already been cleared.
reuseport_migrate_sock() in 2/2 is the only other site with that shape
in net/.  The enumeration of the call sites was tool-assisted; the
classification and both changes were checked by hand against the
callers and against the teardown paths.

Whether it was triggered: no.  This is a theoretical ordering gap, not
an observed crash.  I have no syzbot report, no KCSAN splat, and no
runtime reproducer.  The reordering is not observable on x86-64 (TSO
does not allow it), and demonstrating it would need a weakly ordered
CPU (arm64) or KCSAN, neither of which I have access to.  So the series
does not claim to fix an observed bug.

What was verified: the re-validation exists and is the guard described
above; the teardown order is __sk_nulls_del_node_init_rcu() followed by
WRITE_ONCE(msk->token, 0) in mptcp_token_destroy(); both touched objects
compile cleanly (net/mptcp/token.o, net/core/sock_reuseport.o) and the
change is a no-op on strongly ordered CPUs.  The argument is the same
one used in 5b5d8f351dd9 for the inet lookups: a successful reference
acquisition has to order the validation that follows it.

Happy to drop the series or fold it into a larger ordering series if
reviewers would rather wait for a KCSAN/arm64 demonstration.

Hang Nan

