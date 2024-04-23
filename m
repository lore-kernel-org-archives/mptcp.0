Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93FDDA3
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869899; cv=none; b=Qfe2uJ91smoJyZJHpd3Rak7QEC43gfewfKbGna+2jc6saUlP2H+14kyJHXhDfO4WbU4LAck8I58mUJ86WYl7ebbK1bPliAPUvxtI209D8Exdo1tNdOBhWJEkwXph2HeiqHDelhmY/iucp5BnRVSTu2CdH85cdtfirVIlzkMwyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869899; c=relaxed/simple;
	bh=2G21bZdClIVP3XU1/Itr1EYmTi4TedzOxz7EQAhSp4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVtdPahqH1X6MVMyRCClgo6GArhtqKp+4OZgYOJ6cjQOvu39ecl1lteJnibCBDRN71O0PKqi7nUd4X+BgltF/v53GDoO7eITjjd/XUwojyCXO+EQte76M0q4asIiPEOn6/STF1UQwWSpJcM1e1VH82d95js0hEW9P0BiuRdCJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktMuf61T; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktMuf61T"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a55bf737cecso188034366b.0
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713869896; x=1714474696; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQXXpU+rcfCcur2KrBjeq7ARSKhXge7jDGCsw/eRdqU=;
        b=ktMuf61TmbMb6YwJ260mvjInNynEZM4v0Mb2Ya7T0SC5bykVGQdLQClarSG129FW6N
         0eYWzvPcn6Su58grbk2JYj1Wl/W1LcQJVjQmo88c1lJLrHqGZC3YFqGmjWYLBXAGpsC2
         juITQcZ4Ny5wKg3rmU+vbV4hjQaUThuMjQL8GmkD8xEd+iC5Ya6hvT6eSZzTDpoo+rnv
         HWQHCwWhjvXAfp4KV1HBdmNstxqSM8/2AVmHxXUMCYElIDin6PD4Fenn1SvQMjYjtGDF
         6a3jl5tQwhakvq3e3gFLglOXooicYUGhJsyPEZZUycDXAP5e9m81H3mIWdDmJ+K2dQ36
         3gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869896; x=1714474696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQXXpU+rcfCcur2KrBjeq7ARSKhXge7jDGCsw/eRdqU=;
        b=GMarwa6sFmrS5u/OSvMG0qAjnkZH5lSmJIWHLmOqhSSMJG9NYaSGFHj4Adn+AxzDy6
         zs/AEsnoTjE+fNyQY7FPXhVrsjXR5GWDhTxRfgLFx6rBzvh8YjOUdjNpVmj1T0bzp4sW
         MCOqVyqhaB3uaUqNJdy0iO8mMZ9QiiCmoQ+jyVSCTuOZUY0O9lEiXSL3zX1BJhgAgjj9
         FoKThk5EkyL4kwNH+kFWvRFCrBlWNsBGZetV1vURlZusMqZFCs6E+IQJiIjCQmBuTShZ
         xJg0KAz4cSowAOy8CEN2VlfNaNiEq/akbSgbtIZmpFh6N0W8wY+kSjjcN6iJBfJfntou
         tmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOOGftBEIGWIVwcCgH2exStz0xTfTezc0bf2x+OM4wB5Tr7uCQ+m+3H3Fo0VuIITz1TIEYFZgAdF9m3wLSAZmu5xv3uk4=
X-Gm-Message-State: AOJu0YzaRA7w6puN7ceXlS59rtaPcVvNYItm1nrd6+jgznvtRlfr2qkZ
	JHxrd0+GYnh+297/ZBUm2y1ScRFH13qJeUL3VvrcsWyufBpE4F+BcvWJCr4EqNIHcYZ+/KAzwTw
	bYaD4Fv6qoYw5a7WZb/qJoe8Fgis=
X-Google-Smtp-Source: AGHT+IGqnRrG5NL5x1ld5kYbE1cCFWXHJOxfyZH8DNDYP48sIoXCOmo4KQ1e4gx0sRivopZaJ6wKYVoz/vJ/OITKFH8=
X-Received: by 2002:a17:906:4f83:b0:a58:782c:eadb with SMTP id
 o3-20020a1709064f8300b00a58782ceadbmr1253991eju.31.1713869895551; Tue, 23 Apr
 2024 03:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
 <20240423072137.65168-6-kerneljasonxing@gmail.com> <4ce919ea-6110-4a84-8992-a72a9785c48b@kernel.org>
In-Reply-To: <4ce919ea-6110-4a84-8992-a72a9785c48b@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 18:57:38 +0800
Message-ID: <CAL+tcoC9kD8ZFkEJG2U=i6UrtxKzfQeFe5-q7pCfZ8SmM7arRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 5/7] mptcp: support rstreason for passive reset
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

On Tue, Apr 23, 2024 at 6:02=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jason,
>
> On 23/04/2024 09:21, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It relys on what reset options in the skb are as rfc8684 says. Reusing
>
> (if you have something else to fix, 'checkpatch.pl --codespell' reported
> a warning here: s/relys/relies/)

Thanks. Will fix it.

>
> > this logic can save us much energy. This patch replaces most of the pri=
or
> > NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
> >  net/mptcp/subflow.c  | 22 +++++++++++++++++-----
> >  2 files changed, 45 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index fdfa843e2d88..bbcb8c068aae 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -581,6 +581,34 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_conte=
xt *subflow)
> >       WRITE_ONCE(subflow->local_id, -1);
> >  }
> >
> > +/* Convert reset reasons in MPTCP to enum sk_rst_reason type */
> > +static inline enum sk_rst_reason
> > +sk_rst_convert_mptcp_reason(u32 reason)
> > +{
> > +     switch (reason) {
> > +     case MPTCP_RST_EUNSPEC:
> > +             return SK_RST_REASON_MPTCP_RST_EUNSPEC;
> > +     case MPTCP_RST_EMPTCP:
> > +             return SK_RST_REASON_MPTCP_RST_EMPTCP;
> > +     case MPTCP_RST_ERESOURCE:
> > +             return SK_RST_REASON_MPTCP_RST_ERESOURCE;
> > +     case MPTCP_RST_EPROHIBIT:
> > +             return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
> > +     case MPTCP_RST_EWQ2BIG:
> > +             return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
> > +     case MPTCP_RST_EBADPERF:
> > +             return SK_RST_REASON_MPTCP_RST_EBADPERF;
> > +     case MPTCP_RST_EMIDDLEBOX:
> > +             return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
> > +     default:
> > +             /**
>
> I guess here as well, it should be '/*' instead of '/**'. But I guess
> that's fine, this file is probably not scanned. Anyway, if you have to
> send a new version, please fix this as well.

Thanks for your help. I will.

>
> (Also, this helper might require '#include <net/rstreason.h>', but our
> CI is fine with it, it is also added in the next commit, and probably
> already included via include/net/request_sock.h. So I guess that's fine.)

Yes, If I need to submit the V9 patch, I will move it.

>
>
> Other than that, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for all the reviews :)

Thanks,
Jason

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
