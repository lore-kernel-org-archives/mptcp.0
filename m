Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5E3FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629446308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZJibMhfgOMgB7Uj1Dz1mQ8Q/tzgQ/OaSWNpA1wAeBA=;
	b=Ksp9dXCW0FrIQZyIFFg3kCzQYazQ7YENZFsKwYTXPeYgXe25eX1k7WJuNYm4mwvmZpskFV
	XyIeoBb9oBhhF5BkpHCMgY125HIy/g5UsKqbAwecG3IsGMRJu7EEwbsyh0/OJAAEqZZcK4
	9m2asNCMkRmxM3ova1LDQ8KO6Hd/zJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-ibZ-tU-fPlyuNMYBH7wbrw-1; Fri, 20 Aug 2021 03:58:25 -0400
X-MC-Unique: ibZ-tU-fPlyuNMYBH7wbrw-1
Received: by mail-ej1-f72.google.com with SMTP id h22-20020a170906719600b005bc74a33a63so3384648ejk.8
        for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 00:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aZJibMhfgOMgB7Uj1Dz1mQ8Q/tzgQ/OaSWNpA1wAeBA=;
        b=MDRA649MQfJahM6ecUKEZCP6rOjDxBHFDfI5VXntU6YSoAMl6A+jeZ9uJcBcyRK7zN
         /tdaY4Bt0kt2q4T6cM2u5AWjV+rINInNL6RllT8BPYom4pmkoe6eOsgPkfrsfU/KeJ1e
         R6x6qiYq/plUVjIfKdYRzkmF66m5oRwVjzVBlmFCP5LiGP8wscCqE/fQ81QjCc4zFbrd
         v0ovZvfj+qSFbcbcg6pUdXGvR/tSqF48itiG2dzHQbdM4h+sNLhUwlZz84Mt0c3L98Um
         paGA1ErU9HyXKcjWyQ+0dCSDWhVD1D6cFjRas7TSvCCSDW331PvktL8yOez1pGSWt7XI
         cIaQ==
X-Gm-Message-State: AOAM530gXFIsdgPAMQH+j98SWhmkFDLXpsSBuZoI045RlBMAPcE1QwaM
	+c2sN4McyMSbMoLhLw2Z3o5EjWty/Tbb90BLwiY776c4KNvFCXfsjZUTGHb2/f+wxthKN75xVxY
	7Xx8GUPBX7obXoco=
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr20786141ejc.523.1629446304614;
        Fri, 20 Aug 2021 00:58:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc7E3iLk2wH3/spVeoArcYXqi+jnxXrXOAOmFKKOeXX02nXOnw+cC2/q8GsEISxd2IaWUjHA==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr20786133ejc.523.1629446304442;
        Fri, 20 Aug 2021 00:58:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id n10sm2484637ejk.86.2021.08.20.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 00:58:24 -0700 (PDT)
Message-ID: <5875cffd7ed62665e7ed5770087f7094e690e828.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 4/4] mptcp: optimize the input options
 processing.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 20 Aug 2021 09:58:23 +0200
In-Reply-To: <65cee750-5e3-aeb0-fd2-8342357b4ba7@linux.intel.com>
References: <cover.1629386016.git.pabeni@redhat.com>
	 <1eb5eb91a3cdb5d0f03e20120b1c5c109d690fc8.1629386016.git.pabeni@redhat.com>
	 <65cee750-5e3-aeb0-fd2-8342357b4ba7@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-08-19 at 17:24 -0700, Mat Martineau wrote:
> On Thu, 19 Aug 2021, Paolo Abeni wrote:
> 
> > Most MPTCP packets carries a single MPTCP subption: the
> > DSS containing the mapping for the current packet.
> > 
> > Check explicitly for the above, so that is such scenario we
> > replace most conditional statements with a single likely() one.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/options.c | 70 +++++++++++++++++++++++----------------------
> > 1 file changed, 36 insertions(+), 34 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 0d33c020062f..af22d76f1699 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1111,48 +1111,50 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> > 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> > 		return sk->sk_state != TCP_CLOSE;
> > 
> > -	if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
> > -	    msk->local_key == mp_opt.rcvr_key) {
> > -		WRITE_ONCE(msk->rcv_fastclose, true);
> > -		mptcp_schedule_work((struct sock *)msk);
> > -	}
> > +	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
> 
> This diff is a lot shorter when ignoring whitespace :)
> 
> One question - is it worth optimizing for the mp_opt.suboptions = 0 case 
> too? While our stack will send duplicate DSS mappings when the mapped data 
> is split across multiple TCP packets, other stacks might send each mapping 
> only once (hopefully not, since that will affect GRO/etc).

I *think* even mptcp.org is sending DSS on every packets, to help
GRO/GSO.

Generally speaking, with intermittent DSS, we kill both TSO and GRO. It
does not looks like a fast path. I guess we could add that check with
time, if we see it being useful.

Thanks!

Paolo

