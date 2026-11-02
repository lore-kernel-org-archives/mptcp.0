Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650279;
	b=HIEDQNUiETd3cvaeUZiklPth7IJMTNsQWrA2Cq2ZCU2dL5gWUFwDUi2XW7oFojx+if1D
	 vda774IBg0kYGd5a/xijnx+b+V3T1trkXgAy6SHeFwef4AMVb5x9hHPMO9HOEU9nu885v
	 UAF5TxSawpieNpv9AxHX/EEYPej3Vt6GASa3dpgC0MIt/2cm82G6uFKRXJXHcbid14/TG
	 Nxc5eADcph0vYYufNBOODhJtzxO8wM/w9wOMpDBvdWav6qIIKw4HmQM+JenM8w4cS6J3K
	 Kg97+b7BnExp6emwRXA5QrOv9dMpYBhaOYFRam2I4D1ltSPKM1i2X7zo/aF6FZ/bRcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
	b=KIpmxv8RgYRuw7coEIixTPg4+tLEi7+hQTmOXmdj/lbjafXmjLTXeE7NVcR8ENcZVuMH
	 W+aQBxTiPh1rAnHLQnQqNMbH4OfcZQDhquJXiv75Bade7hQkCBdTlkXjkkuFGNf5A4IEo
	 X9brKBl1UsTvXECIagjwujmHmTHzz52DK2l90k1bvl9BFgO9FBMeqT4SsQDW7atWm4c/b
	 jhT1cqQr/EgjhuVfrkRRfTUDm9WsMnchPCUs7oBxM3DybKmGQN0+dA0FOZ4w28EwJzEWU
	 BIZV0SDQ6Jnkfot9mfqOue6yjgHUmpYdn5nmQ1ksb3AaVmxAk8SJOsvwZByqrjDcHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ft1i+nxM;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DD606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 20:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A19DD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ft1i+nxM
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2814342a91.0
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650278; x=1794255078; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
        b=Ft1i+nxMCOdCn21o912Z2OUOYG4sEWnQ/+OitELzrDZqQt9EP8sGxSJcwnQKJxixwu
         TwbpSr+E3Hh+jy/GJUCEzljRT5O1Y4Vf2KkycDfKlZR3IzTe3rqbXrb3o0SSct0uuvfG
         Eo180XvKDIaJATuFjjkjBqkbZMW3OGZgs6GJfy/vd8YxZfnDRZ4qzTU1WsDcNPO79xLq
         MJE+A/YogZ4sBzmfC4Ywp4mto92S2Gt+yILfk42DzwfthlbPOn1TUz1clFXMfYoQrK/I
         AUr4pxNg0TlixoFe6n9CA0XtQGKevLyYdbB3sQTWywMTeIkoyH0ur4J0fgXa7KNBGlUo
         qkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650278; x=1794255078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
        b=WCZl6O6KKxRnkJ5qCZXW2RI0Jp/eaIscZwyiy1ydRjY4bXT7y7k9hQ0tlWY+NSAMHD
         O2j5g0piZTdAvmHB5ujvXdfZr/cCqi1rpMkm3DV3rmCVoq9nuIycjJFQiw0Wlii3LpiV
         9/c2eC14SlP4TaWW9wdaYmGpR7DcF+OAKQ3JgC9vHELoNE5l23niZj5f+r4Kln/H8UzS
         KiIBLBETqLpNocqpVJuj7M8mD0mwWd0kmU6b4un8aRDsNq0FyyWKwIadgw2nVPD6my6a
         3Xtrr3flEFplEOwzZUnY2CarPXsMgO2WmfxmsHJIBWGKMHtQNyUH6zxa7NdXJ5YseO0P
         2qAw==
X-Forwarded-Encrypted: i=1; AKwUvByNEpYcKV4I8asPEjZyobkUF1L68G2nSZpViAhgQtaCMAT3PgVqu5mGAykm5/eJ71PKkAecTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8RYsU6MRahZwMWeZNAfvFkPAbCcoxFqznxxqZ1Fvt/yfjdiRKV
	aZ7+LrhBB+IVZpOczxYOF4jKP7Ud/v5MhkrNhQjohhuc9Ynx9GelYfMI
X-Gm-Gg: AYBFou2W0CLDW/Foqb2zue0e9uGD/nGIgAhDtNgyxTqOcryDU/ItmG42f9XVuBOG/AZ
	4iJ+lYUdJtmsrQg4moUOpVOHEiGRuJD3d7zIPjlopfttJx9ISYIEWu38yTBG3ZWS/OA1m16JKOV
	u7S5Yzy7Qb+ICD+9yZYYJd0lhI2FKee23+lq6gAXFk1XNifed0Qiiydyor+XZy+Wj2AXp3FvFOh
	OxyP4JPPqFBBPYaUMbnVAz+dT4zjFOZ7YZLwC9m9YzUqGJsCAh3u/BanRAfRwdMn4Jh3CDzZ7NO
	PGRvo9K7SnmVSiGjv4bS3ty8AVGVcKkMomYb0ApNNT67PJuwED06prJb3j1EwYgQ6HBLfMFPn89
	YrgNZB5ehaSutGRE7EctOwQjE65HbIC8gHrBnY7vl/EnVIjm0vsMQOD409vjuzLDtrg4f1twzKI
	mEZBfH/SIBnkaUltwmUFiYU5WvdwbJPq/tBsPiUEbn5+Q8TuhHCQil4CoJubSJO4ysRsGWhKPne
	HEfA5EOnwaKELSt/tpXBAmIGguGtOutzTglFCMoKMCS7/hSnYNvTBKdiz7/MwvahYscdj50xE33
	i3DoB75RdlUVzA7pm5CZ8A0jL6QVdusorQ9qzVFOq3tg5EjOzCpg8NMXNR0pLq2+F9/TH4SbcMX
	ujx0=
X-Received: by 2002:a17:90b:2742:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3ae897158ddmr9622591a91.14.1793650277913;
        Mon, 02 Nov 2026 12:11:17 -0800 (PST)
Received: from john-p8 ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c29e619sm780797a91.0.2026.11.02.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:11:17 -0800 (PST)
Date: Mon, 2 Nov 2026 12:11:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, 
	matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts,
 redirects, corks and recvmsg()
Message-ID: <aujuOJCs5zZyon2k@john-p8>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>

On Mon, Nov 02, 2026 at 07:20:57AM +0000, Alexei Starovoitov wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>These patches fix bugs in sockmap:
>
>  patches  area
>  -------  ----------------------------------------------------------------
>  01       recvmsg() after a fault
>  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
>  05       the backlog of a stopped psock
>  06       TCP listeners
>  07-08    the target of an egress redirect
>  09       the TCP state in recvmsg()
>  10-14    corks and the redirect target
>  15       bpf_msg_push_data() and bpf_msg_pop_data()
>
>8 of the patches are from Chris Mason and Josef Bacik.

Thanks everyone lgtm. For the series.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
