Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937237B3F2
	for <mptcp@lists.linux.dev>; Tue,  5 May 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998924; cv=pass; b=H9ZPYAKI8vZZgWslc8kpyEgk8rPKXEEyk/2fwjG9KEI47+OoCcORJL2dJ2kuhKhqOMe9CDsc/Rov3wI31nS050wAPrGFkcHI+9uSAS5PEQlkdCXJwo6FnGo3JB2zIPC3y9iSfQSmfQLAfAHH8pEstCdG+UcU64z2Nb6gdAdenlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998924; c=relaxed/simple;
	bh=J/oQ8k1Ng/Re8WB5ttPOUKqZSOeyeHXazZbRTQVCI34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZNc4fznipL3328gkCktU9AJiYoMTXlNL0lc4Y908+THJGNHW8D44jDPcs8bUE/3owYRF+GLZPH6C5zp+PBaqNiKL3gctfDbNIdW4Xgix67aUq2AxTxEcEubqE4EhvEus0bbX/5RAFgZ9JYaY0lvftbXMX3fjGVDpvhJWdmpw1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHFojMNG; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHFojMNG"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fae4d1f85so71126821cf.3
        for <mptcp@lists.linux.dev>; Tue, 05 May 2026 09:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777998922; cv=none;
        d=google.com; s=arc-20240605;
        b=NkT7xOOdjC4bUTExO/e5ARphzGr4FzleY6TCtIoqaskDxKy0ti2MtP7za1AMJmOMuG
         3DkXNT2Bpcd3E9vaBh3oWnVBYtDy/PXcaYVZKXH5s2Y76qAoXghK/N6DZ+w/s7+nyv8w
         8oCR+1TG2qetytPdX+SJi4UcIDIHOVvvf1tTsYy549t84lEmh5ETl/0oyMP58X+ncLmH
         YHa1ZCsIYG7f/qR6tcMNtN6fGUXRAPdM1ECWq6vfgsdM0Nni0bCQ1y80NFEVwDZANu9s
         yfYMWjfyL+h+h1LfXUn+2qTJWEwWxCz5YdPvQLNrUkMxluUMnhg4HvaVHqjHfsCM9Pgp
         C3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bq/E5ABMid0kqYiPCLs6D9y1RcHlq7rkIB3i9jiFL20=;
        fh=6r9lJ6d/nGN+75j2WJczKVWO8SX7CgPj3wi0MaaXFic=;
        b=CxeRSewWqdjetHZJ8RTWZW5Q+juem5wMyqR2puBp6A+YO9FApPuHmmnyiqp+eucEuu
         L9i9BQ+TxTX4GTAr6qxEFbuRyPv/3Ilnp/xWbmDXq4sCJb9s3uKKw4j6dJz88laK73AZ
         J72KwBJc7lBUGMYK9q9HLaYzbTABXdnYSK6XUGYmjIz5PpJHHZwasFDV/lzeNArEdqUU
         HbDuJIuRzBTwnrJ+qoKD5GBbDOqTEsd17QCBnf+82dB/5zrTA4By+fKefHnPJdbiY/wm
         I6PdF3BU513J9jKlkxgNFs6kqZVwpaxASPVj8QHFq6LzgykqscBt3YIj/t4ePM/clcWT
         h/OQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777998922; x=1778603722; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq/E5ABMid0kqYiPCLs6D9y1RcHlq7rkIB3i9jiFL20=;
        b=KHFojMNGRwSQ1zoaTcR1DAaGxX0OUMrc0Q8YqFTyqNh0K77ga8rcVNDj4IGCJswfm8
         XIVAlLa5bcFJjbzcWxjIwTSOpyinro+wQKjrzH7QK9fIhVUVVh3g2v/5kz9SmlD1/BSy
         0ZdTtC0W/NpqpYtGql4Hr2MqEkVdvNrTAjEl5jiwG3Gnwfjlvv14b0II/KWOsdix+gSN
         hgypMXKkZ4TfusI+mcDoO4XiP/Ge+VkBvKGxDCNP2rv/v9liquwrLeKwGQ0jMF5WegfW
         9TvPM3C1WJbfk0itet0YWncxyO6cJbVGFFNpMSvLb5ff6WTY+sG8uFTIMHM9QBP61JfQ
         D6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998922; x=1778603722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bq/E5ABMid0kqYiPCLs6D9y1RcHlq7rkIB3i9jiFL20=;
        b=MvqDBe7LUxldZ2ANe4jHCNEhJDgF1izMQ30qxMaIIbuWOkaOgrqKqFxKEy8TRjJgch
         7g7/ndaoCc4OCSeSv6PWZnCmZUXHLdCvFw10YGG0OJwjIrVkkb0lgVQJBMy3kTlIt8EC
         FNVeZ5oAqpksWofDphLdmdODxSp19I/J+AlUWN0DXYEnNow/5SG5Vt1EOFpb1PM33tfa
         tcI1GTGQBV/5338p/Z5+6DsyvuaLN6GNoZtNGqJNEyX+0wW7inZMgLDXC3xPlDWufl/V
         isyPmseQ5+4r+n+ob7ILmSSTHJjXKEwXbLjHkN1thPvQH4kRpNt/+CBUecb3+lcgKeZY
         bAyg==
X-Forwarded-Encrypted: i=1; AFNElJ+u5im20oxl1mD3iHny0XWDrY5iIMlVvR9lZwM4DqzqTszzusQ7+yHiWK/LrcYuLv/3arcJgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhIoihdn2psUZUL8ihf5ksSf4cHcj/x8XHQQeSGfrK8zpyielR
	6SGa/Jq5AO0u+Q11KTc6o2lKtGPTfyzwLXSuuriFaCQsnnG9GlOuIaPN6rL1QFg6pgJcC48q4kb
	6OVIIofmRjZpdcNtpu4aBesIYSDuPTdO0jfZuoFZQ
X-Gm-Gg: AeBDievOrfOmpV3Io7yBjJQfpe0XkMrAfB3rrbVsr/oTDMec0WlvuZGZNu4FLSyQNir
	a7LjFUMs3L4Tgij80LLJtCMM63uWmLYZWVU9mzop35pWWnCIpUHioKoQ3ypZkfEZnf8askzeWcX
	swntdYcaLKnuqiQRwVuDh34O9lY7cC+0+RAg85hwIRNYHKKsoo58sI7q7eW0rK51Kfsbllryy5t
	0p20wyrImmqrE08Tp0edxIgBU05ZtNckn4wFZ9MQDxrTtJPa+ag18AeMDyZ4hqu0deAFRZKkvlW
	6BBIx/pceh8cxwmsJlLhQxNs2DP8awNXp2P1dBq9d78H7ONgd6pfrbx5Ow1/Y1tHV+HQNlSkaBQ
	FLgfIcdQcsho+spyR/yobg/M4K59Et/IEEEHJQ0c=
X-Received: by 2002:a05:622a:580e:b0:50e:5e0d:98a2 with SMTP id
 d75a77b69052e-513069de195mr53128391cf.26.1777998921378; Tue, 05 May 2026
 09:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1777908248.git.pabeni@redhat.com> <eec217c214e8db54355c7708b328c34a92c2bdcb.1777908248.git.pabeni@redhat.com>
 <0c361889-533f-4467-b908-0774dc23f08d@redhat.com> <CANn89iJk+0M6hAxx+L8vfLzCzo=_7E141BYty8F4CiBUM2F6hA@mail.gmail.com>
 <1bcbd71b-8b7a-42d1-9726-c8b58e3bc3ad@redhat.com>
In-Reply-To: <1bcbd71b-8b7a-42d1-9726-c8b58e3bc3ad@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 May 2026 09:35:08 -0700
X-Gm-Features: AVHnY4J7RhfZpjUABp2b1qn5dW370pbkVVsWn6kcvy4-Bq-ZpeSDsfFMW9S4rY8
Message-ID: <CANn89iKzAM87Sc+1oyr1LQJcg1qTLHULjq-N1oteLZq9uAz7RA@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 06/10] tcp: expose the tcp_collapse_ofo_queue()
 helper to mptcp usage, too
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 8:57=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/4/26 9:07 PM, Eric Dumazet wrote:
> > On Mon, May 4, 2026 at 9:39=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >> I'd like to re-use some existing TCP helpers (tcp_collapse_ofo_queue()
> >> and tcp_collapse()) in the MPTCP code, to avoid duplicating the non
> >> trivial logic there.
> >>
> >> The idea is that the 'struct sock *' in such helpers could be either a
> >> tcp_sock* or an mptcp_sock *, and the processed skbs could be sitting =
in
> >> TCP level queues or MPTCP ones.
> >>
> >> That poses some hard constraints on the sk fields that the helpers can
> >> access. To make them clear I'm renaming such helpers using an 'xtcp_'
> >> prefix.
> >>
> >> The full patch touching the TCP code is below. For completeness,  the
> >> whole series is available here:
> >>
> >> https://lore.kernel.org/mptcp/cover.1777908248.git.pabeni@redhat.com/T=
/#me6eda13ec2c70fbb400b6223aa2d07a4fd3bf865
> >>
> >> but I guess most of it is not interesting for you/from TCP perspective=
.
> >>
> >> The MPTCP bits are not yet finalized, but I'd like to know it you woul=
d
> >> consider this approach doable or a complete no-go.
> >
> > No concerns from my side, if we except the fact that TCP collapses are
> > a high risk, we might
> > remove them completely (or at least guard them under a sysctl)
>
> I'm sorry I can't follow the above suggestion, could you please rephrase?
>
> The patch should not add bugs to TCP collapses for TCP sockets or MPTCP
> subflows (still tcp_sock). Collapses for MPTCP sockets could become
> buggy if the tcp_collapse_ofo_queue()/tcp_collapse() implementation will
> be modified in the future without care.

I think TCP collapses should be avoided like the plague.

They were ok 20 years ago, when 'line rate' was 64Kbit :0)
