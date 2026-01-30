Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6234B1A8
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804332; cv=pass; b=bGdRlZzFDWGQF8fScmslKXf8Loa59ViRS9rC52S/s+fQC05qImkhIRzzDmoPwSLTrFtq3K0UDL6S2sJM5IDNHmsyYZ435CWtGIPU82B6+V4rAyme0CgXY43Crw98OlA8DstpAOURB1jAJFrtuGXvTe+OMrGg1KEJN3K2H+vtSqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804332; c=relaxed/simple;
	bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3fOwO3Nzv2C35cOJJX9qwku8AEG6aojDQZG+EOBsk1pHfThL5ggQgKgGV+/hL1CKLuvjCrT+AyxMS9KVOqz0o+rmzc3Fod2yOdm3Vod019590NxBi3XbP6/Zjia+W0CuAFmZnWtPdyJG6HjeiPbsQvjcM5xdXRGrfbP+g53IJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfqY8Eks; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfqY8Eks"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-502b0aa36feso30648591cf.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 12:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804330; cv=none;
        d=google.com; s=arc-20240605;
        b=ecB8z99D+SekgMwIOzB76WNzsWzvr8t4WDQSJ7XQUBAi5qYe4MCckYadUZjLg6tpSQ
         FuFBQgGZ9GiN0S8kspfhM7q4O1kwBrSJvxjrv4y3zY0/xK+qtkXPM/s2NsG8gsEQvkS/
         yJmp614hHayKxmMSSIUv3CvQIN8yfXi2llm5ghteyoRzQW8ziUJlbTGtumtShO36puYn
         B0l56AnvJ+zH2pwhmRMNgVU+1NZfkSuYUiCbiarotGEdCYs0l9gR6LPxzrvmouS6iLnH
         Cv9vssvvvc9rRX6W9lGJaHQ4YNF0Xu9hUlRuGs5eBmQnYQLg9x1iMqBhbuTNglpM87kd
         jPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
        fh=7ufmvr6tPJ5HP8IP6c/V4ud6qEJfsOFESWWy0MWq/5c=;
        b=IXlznQPRs5pEBUj5LuaTMIDQjuFMqE637p1thAAbCeL8QoVA1WULQDH8YOrw3vW4Ro
         aEsvaTW/8L90KX2Kh6iyhSJ6UE4CIfr+QJKw7jgbNlRatk9Adq+XJUE+kg4rvpApZrHJ
         grFzN2aAV7tB0gLw8NYgCDPsCBGAXovOpqSqdFfUpTwsoVXLxy+LuxfagxVCN42TovMv
         SstOlgw09+ucCOW5IJLEgBAEAxuOQc0rHwD4XdYy4r23XH1R2U85BeTrLYGhWdavvja9
         ITMs56xX1yyVjX2bkjkFmKZc6I8SaZWow+5IbU0KiI4oih4CXK2tQaifYCXDFqjWU3Dd
         CQXw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769804330; x=1770409130; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
        b=JfqY8Eks3lmnQ0mE67EePpco/2CzZJjePQVTevvq0UqbAmrZarW+u0+8Gh1vqFR/lF
         0yrIYq6vVWjKwC/WaodOVc/mos9EdevRQ7tXZBcV5089V1z7mjjWPH/yA+/lhiNdGGPa
         A9vn2uc4aOtt76QpUlsMvpFTXoiM1KNeoEyUakHDhx2PVm7yf87wf8Vo9054albI8d2/
         ZdISgkaTo6S5gxk1dxIXX6C7txv/xyzS+LPZj+oU8Dt2S9tZN59d/MwW6qj6vE9faZfS
         SnoYdOPz+EBD5B3eael4pur1wT1fk4gCunXj7nJ8A2tq1BqtQxlcfHlLPGAhTClgCq8n
         byAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804330; x=1770409130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
        b=sWX2oX4fxQdUIMTpf6DMUwWHXlBr3FCisUfvWT+iEwCjr6a09QSw/MWendDR1SJn+S
         AoXYHoHf5SsKlu0I9CZl+cZGSK8dlPnkwtAvdw4zB3/3O0mBnCwad0fGlWE4jeWV3ZKE
         GAb8pisccWcLtAwQvNo1JM8xaYIAHW6jr9sO5lHtdlecU3VR6IqunKG5hnFyisTpvu4H
         UwQkV+aPg0loOuBeeLJ1QaSJlyPmaco/LgQkU4DW7tmxabCOjrRA4mcT/gkXMGdyur6q
         NXmagRwYYGt3pS7xdbJIxAshh+zghIDZA7NNrb/ZkGX1cazHjCt5RzjP8EeKlfUJpTvv
         mJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCW8nZj5IPnFnUexrH8ZVrigdXwjSgaP5GSCqhP4AozpUW4kVDIwAbeJ2aHxn4akAdJdyGszLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuzwkBE5TrQZEzTuJ/QJQNWc3yWAwMS88gK8quqrcfLDQ8f0w4
	d2EkHyDNgi2wLd48YUqzNgnsYfPFyyvhDMSeFXRnW6GiBCfn8b+i1DytmDBL0/bjBBTZtdIky+0
	ARApQmeL7Esev+A/IznCksKxVVFdFHmJv+HWHDuAO
X-Gm-Gg: AZuq6aLfwwfRNVdRQ9p0l6qfR7C53C2TS/vOxLC1yzpviIXT2Ld7yLM3ckv246VJaiz
	ISZY+mZTSzHqk/z5soERuj5FkMcSr8EWQlMojx9cmd47euiPAn4/1DII/Th4KqVcwwCnvQhhMAb
	jQpodC0yh6f4oNyhgZo/zW+8ksx+jxFHVZawbuINU/kwkm83iLnoTn2By58yGJf+Gg8tC3ngdsr
	qxQcoXJuP53KGip8sp3qUCntVCJaLZsqwkb8ZGylYfYIQo+oAfq61FSy4YSP7KpjF2wRrk=
X-Received: by 2002:ac8:58c5:0:b0:502:a218:1cf with SMTP id
 d75a77b69052e-505d289d77emr53380761cf.4.1769804328557; Fri, 30 Jan 2026
 12:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org> <20260130-net-next-mptcp-splice-v2-3-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-3-31332ba70d7f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 21:18:37 +0100
X-Gm-Features: AZwV_Qgee0kWrUcrGSbV870oEmI0azfGZzvyJVxkG1CCnUqUQKho8S6iTRt6gAQ
Message-ID: <CANn89i+kMpgCa2F0c+Y3av0OfbW3B0gf=TEMQD2r_cEVixEpqg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] tcp: export tcp_splice_state
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 8:24=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h
> so that they can be used by MPTCP in the next patch.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


Reviewed-by: Eric Dumazet <edumazet@google.com>
