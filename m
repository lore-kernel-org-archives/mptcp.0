Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645361;
	b=EnXuhTh73BmcAkgE3GFNV5L4Y673RUz8MQ0d/uMoPCKAMHFok8hKnwS1jUo4+hWd4eW9
	 vsB6Rc2+6BKM3S94czjGuJ5g5MxDbtgd2dprCDslfRWO9bfPPlDIZmCJrlkxlF4DLnba0
	 3k1b17zOCj9QwHoNlkzGf8vjE3rIvqMdDz4BRiBsYKlsbnYYNNqzIODUuYNMXqdBgqK8v
	 ctNk84Nx1PzEuUOIO68EZR1C/RdOuFfmCiwtVOGXed/SSqrwJlqXpdFbODboPRqO64/iT
	 Q84bd/DY8BzG+SuXQXepH39WBIqOG8mKI1NI4n57TfzGcN0J+P93b0LXijI/gvOdVIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
	b=428jXIq22SWnLUDeIaunJMd388v5WZaS3f7ip1S0MTOZymyaNL5iiZ09EQQqam/Uop2T
	 NeZsv4OGm1z+1Uaich9J90TWs+qGhuv9zWR9ziX2wO7a15Pil2W5iyOZJGlkMNUz6P/hr
	 PUDvCqL/BvbDaGrrNbzGFECKMZpZYr/fexoKgUpqDB5lzco+R0r1q4nO0Vw+PgIG5NIdq
	 P7JAaOMf+qPwpcSmxSopQxuRF9PvnP053nRrFEoPfH0RC6bx3LMRBmEzh7OKH48WukC7R
	 o1NN5k65/pNgXJtaYU/AK5MRx2vny2i1yidfvJHAKHP4usUnu604caxNEmjsHbiYjDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5NGlKpZ;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BE606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 18:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A85BE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5NGlKpZ
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1636694a91.2
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645360; x=1794250160; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
        b=Y5NGlKpZ/bwVShwU9FfLr8t/VSqLTpCPCHBi+FMACi94opl66/CnAPVTtn4V9w2QjH
         Nlw6KTdWkwJHSdZenDRgms5ohQ6og1pmfvIc1jWXRZcEZETI6lgTJ3zoF1lElzoiR38o
         FocQHsjcLdoeI41rfr48v0JC2CyLF2dua/Y9gSqZc34WCq/QjJf16OPdS3WXnxgFl2tC
         MVq84TYHSLFyOtHMAjnv8YydR6iwp6xFlOh5mMi/wo20rWEdHbILk+iKE4PUVdG1JH7L
         +IpN76t9cf3Bs/mKzJnYEegKGZf6Rs+pRR3T1aZFqJMQHvYEMR6JS7vX99AJQ6JcFZ4N
         RZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645360; x=1794250160;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
        b=BTZNDD7x/ruJ4tWl93r+QO8hecoa6hkUmx6ABoUuVe7Lgvazfs8lyT5esl+UGB7mWO
         tSfSTM/LeN5xT28WPysRQkfANjePtMblTTI+3K+/zFNoSj8xmfMRiUOR8UCcV8E+6sXN
         icr8gVX7hCgU/8t20YWMBKn90UxF9j197bAbZSub7TqdZgFGTHt+yya7HnO80V8U6Z2E
         +dS1nXj8RHqZQ3cV8B1hSlrGN7EMWjytVFJmwp4pGMEFqY5TNqnht8Q5NEhRslGdyYI6
         HmZu+BGYWb+XWWb8i4kvKUFJIT/nnMy+hfCt4/rFZ/bvoi+C4DE89E4PeHSB+RVVq6qk
         0DRw==
X-Gm-Message-State: APuU4Z9/Q9TcTkngZfoQYrUazXGGH6fhGZnhreU41Lg7ScTHNJ9PVaVu
	/lZjEoUgsQJBHNKz2J2/5zgPCK+XNYUB2xTZqpJt21xoLswsUAAfqNuMnW0ELA==
X-Gm-Gg: AYBFou3XiY+QB9x0GBj06QPOiwMAgJsVGhbXMYRhWyCteIXqMVUTP0lY7Ql7T/OlSyG
	0E3pCVuE/5Jt+PKiSslo9cDjCm5D3ue0fV+GLygTCwAP6bOTxA0ckyJVdrEhrvCzvoBYWN0P9BN
	pF1kWoDQOMHxa2KDgpOncoYdQR8HMOZu53FpL3Qv2yCgMXb62GeBqQNDt3o1cT1DkaBF51q2rtF
	HMXOCMd7xBtWgAWQATmbFf7qi9yllKP0r0cO/9Cot6xHHvsg/aMQQICWRxNfCy8pUc2NzggM/L2
	DtVvjppKWXKSkHC7lNLKjV21dU7cubD2lx3PvMXQ4jwBuFjYfpbaGo0eBt2RcCLCOijWmpSggTX
	JcrLX+ZuHp5fcFS9IwoZudm0o8++FOKWmjGUVL1Rqwb6pWqSFdYsk/C+Gwt8GGih/X4aIHMenUT
	e+ncjx1Ha++HznP7Ol6ypDn/KmULGzVp7s+cvvZWgaHfetXdYm+DWU6ORQWoNukxKYy1uK+A/N0
	Dt6uA2HuzP/6TRNaAnxPaj8q2JfnET4ro3+9/JPXHSO+vK58S0iA8sDhRxvQRrIkhL+U31z1IiS
	PeftUXCuTTA3iQ2omk006AzazN60QA3MpjN+gdm3SwZiCqQAPV7axgCgLHDVtNjo+LmL
X-Received: by 2002:a17:90b:48c6:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3ae897e0e39mr7985674a91.38.1793645359949;
        Mon, 02 Nov 2026 10:49:19 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6271ccsm431541a91.7.2026.11.02.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:49:19 -0800 (PST)
Date: Mon, 02 Nov 2026 11:47:50 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
Message-ID: <tnw1m6.2g2esuogz4hv6@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:20, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>The verdict of an sk_msg prog is valid for one message, or for the bytes
>that bpf_msg_apply_bytes() requests. These bytes can come from many
>sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
>psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
>that resets psock->eval is after the switch statement, but the __SK_DROP
>branch returns before that code. Then sendmsg() drops all subsequent
>messages with -EACCES and does not run the prog.
>
>Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

So no one has tried to do apply_bytes + DROP I guess. If you want after
this series is merged I can add some test.

Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>
>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
> net/ipv4/tcp_bpf.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index 8cf63a9e7fed..d90bcc911b36 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
> 	default:
> 		sk_msg_free(sk, msg);
> 		sk_msg_apply_bytes(psock, tosend);
>+		/* The verdict holds for apply_bytes, not for ever */
>+		if (!psock->apply_bytes)
>+			psock->eval = __SK_NONE;
> 		*copied -= (tosend + delta);
> 		return -EACCES;
> 	}
>-- 
>2.55.0
