Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430F3F9F48
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181501; cv=pass; b=pH+Ts2LNQCsqzlt7O7Si7NLyMIMjJUYGvIMRSn9tNh7eVGLXZ7Os87qSlwtPUg7DK7JxVXhRNwenfzPlv6NfdqwHoAp0ls9tizRaOduB10vmsZpG7G6VWQuGR1sB+FwC0Oi/yB9mbBcU+TtO9GGe1s4Uub1KUPJVxExI9GTelws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181501; c=relaxed/simple;
	bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOToC88VAQf8KppdlKWmTbRWYWWikU5jgmG4i9+2Hik7CKMMQvLIUkc1zstp+UER8sKg7hIcb4im78If4tAnprulU2US96lt9VYbJlT2Qh8Z6bsT4lSzc2h8goy6eo4VoifsmMb72u4Pt9yA1hsFTB2PsC/5v+ZTYtEsmiVtrgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYZWAafT; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYZWAafT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51761d27612so92242691cf.3
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 05:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181499; cv=none;
        d=google.com; s=arc-20240605;
        b=DkGXBJyicsd/KI+NBTgWhJt7TBLFEiOuZV9MQxvENsV2wVJKP6Rcxwb4tEaLpI6TIL
         9P/Cdvuz3jqXaiIlHiKP9LWxAWxyEF4KlLxoZfQDpYgpV1kISOPFUthX+S8YxWmxY+3W
         tsBJNsdpPYni1EMAfg49YdLmn4q8U2VHGSoGIz752Hq0o2uHM60/pUgBrY/7EKr82Nki
         rr2OROLmYf1IE4aWs77CcpUwz9VegvjjcuE0Uwe8lNgZjTwOg65dlfLevlAocSG0EKEI
         qRWI/dIFPtYoe9MvEjpcdzFFLVAU8qBfY4sLAfil9wOF/ohu0kkqu4l+u3Zb2RyuTvgQ
         a9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
        fh=BH3PDRJACwU23uSgPDtrhZjzNdHN96YS2yYPRTcOdoA=;
        b=Y+ox4Tn1x2ZSFxEx9UAuiw1n2Yo6pU48x4/ZVQ/RXeYRf79RYoJhX3f6tZU3zFk34a
         jxlMuZruvS583hXE56++7n7PtSUHZF2quKZ4klyMiVIlfbUgk1626lUB1P8NIu4YkrBO
         RJESungr4WSBH/s5nkNsLb59NfTzMUZhcaDEQaO+RzsJ0oY62/+4Hs6YRpy3T19tCCUF
         Y2ATyabgvO7e1m0ir9f5BMw31pR8JZU1Ap5zXiIRFmpFm8pdReX5Ft3iWM9Vyu8T+/IQ
         vqkiOLzLz4NoFZRG5EI+EivRXFfg2TEMTmBU2tjnwuG/4YlKzxNQ4H/1CqHlQYEDcEaQ
         /CQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781181499; x=1781786299; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
        b=eYZWAafTuTYrCJ/Oix4TaB8z4Oww3r7xQkoRYMOdpK7VV60pcUwFTfyvR71gQGCPbw
         unBdJj3XV2L3PeInTz4N9bQJR5w/3DJBlezrSAQUXAdJwSs5w/240SGXmnSq7zSM0Ido
         9PvzIiUmaEqONCG4pLjA9wWhRbymZbYK1RMMDENbh8ulqPYE58JrLOap/jSv82ClOQpN
         6RYPSa8jvTXdq8UgdZJp5DonTOGyvgtVLPws52aipF5a1A1XGTbAIwEUPpCiB7RTo4bn
         Q0JTkiIjyIU5HEkUKfaISsdGB7Ong4GRJAKjCCRMcubsjFxMn9VEFVB4df6et3vkb42j
         tSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181499; x=1781786299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
        b=BnzE1cL6BTXJVJFAG+W73dauxLYABhLkBEvxWXTzS+0Ib6ianWDHXcqymjHs3f1NoX
         7y9D8ms+XUKRhsv9dxw5M3AhpqZTJSoPIZ7i68Vq6sz3J5QiTev33DriqftdVIoY5nHv
         51Eeaa5Pv6RhJ0bjalXAzqSCnnp9KpC/PVt83jfyyurpxs5KjOLmxK/zpP24u5vlsDrP
         kl5/HkrLkZqho8VyrT4OdzMHU18VhAAw7cGLae3gzalJjzEX+MCbKrRx/JWYBanKPJ8j
         FH9XPJqq3cIyxm3a1KysM84RYXe3A5p8gjRvnNxrkSw/V5GLyES8Igxbod9fMyXAluyC
         JgJA==
X-Forwarded-Encrypted: i=1; AFNElJ/89IVpm18kfazMrkRJHMtnLE6yIMXS2J60tLRJGRdnrgZ9h1udzPFwIMFpfrjEr0BLTDyAdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4kt2wO9v5cM2oQQOovUfYvh9YLlsWco3yUBCEflEiip/kiEAl
	0hUt6LJOuE+/dFHnceY46SWeaA8hwfThrImAe2EfHvl7QtU4gIRB/eMfkcWme4dvJzGG6T8wIqd
	nq6KdoQCXEahW2KI1pvRduDVhfpGfhIGODhO+uF9v
X-Gm-Gg: Acq92OFVqFKp1uokd0C0esFQ89OCga+1woqxp2zzJtylBmri6wT1iahHa1BOTluz8tO
	kjtEyVdwTlqCPc6XuChcg96Xa4JYSa5Iy8lmsDrPqkpUdxhc/19bPTydbkDpTnF0CWNrQaOwkNw
	buOLyyq2vB+8YT43WlKrMEoMunT5j3vAKFM5QvkamJGgY7V2fzpVw40FA/oHqHgTgeyc7IEazFl
	XoYGhJqWq7FWsKnrN6rtUnWzfIlWvPOGontw8bEorc/HgQZcjL4xQVcJbSQ3GTIhM5jg6M18IKd
	BTpdLeJZc1Sy8ueVtTKruhF43C+RoD+I9OF4o5CHnaYrsPyWlmarJAO3K9xLGHNF4TVUI4J7Nyj
	6qf/Peznr055g+oZQkOjBdOlda1qguM4iAy9siHKY
X-Received: by 2002:a05:622a:54a:b0:517:8541:8b70 with SMTP id
 d75a77b69052e-517ee2144afmr39725381cf.45.1781181498220; Thu, 11 Jun 2026
 05:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
 <fb96d949-dcf5-494d-8076-eb4a972fa5e4@redhat.com> <1014329c-d60f-432a-b165-62866ca6a4b4@kernel.org>
In-Reply-To: <1014329c-d60f-432a-b165-62866ca6a4b4@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 05:38:07 -0700
X-Gm-Features: AVVi8CeWcYBSHusf8PMPiwu6R-DABtcuuO6WPLkteSYaC0gxDZcGsCxGDjDoZO4
Message-ID: <CANn89iKZRmLfjO_9JURrx_6Hr9pMaQwD2zABc+dHyXiENXHNVg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some packets
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:49=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Paolo, Eric,
>
> On 11/06/2026 09:39, Paolo Abeni wrote:
> > Hi Eric,

> > I'm wondering if you are ok with this patch in the current form?
> >
> > One thing that was discussed on the mptcp ML was exposing the
> > tcp_out_options layout so that mptcp_established_options() could receiv=
e
> > such argument and likely clean-up a bit this code.
> >
> > Not done here because placing tcp_out_options under `include` felt a bi=
t
> > "too much". Perhaps adding a `net/ipv4/tcp_option.h` header (and
> > including it from the mptcp code) would be more palatable?
>
> Note that I also didn't do this because that would mean the removal of
> the TCP TS option would be done from the MPTCP side, and not here from
> the TCP side. That didn't feel right to hide this from the MPTCP side.
> But I'm fine to change if preferred.
>

Current patch LGTM, thanks!

Reviewed-by: Eric Dumazet <edumazet@google.com>
