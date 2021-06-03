Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1670
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622719827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sByGlhIGhpxQKxtu7s2Bkt4NieT2OfbOBqnxwwwWBfQ=;
	b=R1HOOTFuAKPOnUh7UAW9aVm9pgaipVf5IS/ib36+uUcqDh4HQ18MUfMU52G0hY9Q0ed/tD
	lf9hOfDPa3w8clRDaHjPY4ItJAYU0y19NG8zd4qnBzL7FhCV4PosNRPqQkuqblZWLSF3tp
	/clNlULJy+M1R2S9YIvc4G6RKkCotV8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-P2A8BAXZMX-QHBhASQR_eg-1; Thu, 03 Jun 2021 07:30:25 -0400
X-MC-Unique: P2A8BAXZMX-QHBhASQR_eg-1
Received: by mail-wr1-f72.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso2315278wrh.12
        for <mptcp@lists.linux.dev>; Thu, 03 Jun 2021 04:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sByGlhIGhpxQKxtu7s2Bkt4NieT2OfbOBqnxwwwWBfQ=;
        b=W/gigtS4q4J8xVYvJqZv3li2YYZniJmB3wvu0cqu5EA909c9Di6CvQlGGzYe15puhL
         uy/kf7/QbDnSvfj7LgGA3GyO5zhEnHlFVyLJ9+FfehrvFOQRNR1NL2y8HCtH7AQ7fCJ8
         eNX7bMPFMDb74xJweXS0ZtKGCz605yHx3eTdbDXmRdPiwbPlLK598ABS0qYdVgsvncCM
         iAr6MQTp1xFOfgUVsciHNb1LJ6Sp7xI3+NOfyavs1+t3LpS2+Tfxaxpe0pV07eTG1gHk
         PHfsMdOjgsJZcd/7/+ztSGmrsfkp2VkZOtfAzcfUdOSvMWlo0dwtmpmHGUW9c2QAScNg
         wkhw==
X-Gm-Message-State: AOAM530PLb2s9dC2hPwVPNYkAXvJkgtqCcUg17H2JcAr+AMbw5uQMWmT
	mhO1ObRi4yOyBVNEot1DTJLHvKXMh7gnnVO1A9LJzNk3KLpL+qjKYq52iq+LoFMcmuDdocHhQ+J
	QVWtUYCjVIvJZxvs=
X-Received: by 2002:a05:6000:110e:: with SMTP id z14mr26677765wrw.235.1622719824599;
        Thu, 03 Jun 2021 04:30:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhZydWCR04sCn0w60jzrKlwfnFbJ0nwoj8pv4KaJL7TOirjBevNsds2JygfYUmEUeNyNI8iQ==
X-Received: by 2002:a05:6000:110e:: with SMTP id z14mr26677747wrw.235.1622719824351;
        Thu, 03 Jun 2021 04:30:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id y22sm6650627wma.36.2021.06.03.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:30:24 -0700 (PDT)
Message-ID: <fb4781dd29d0c7ff4f81e5cd44eac7c4434bba8e.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: let warn_bad_map report relevant values
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, max@internet.ru
Date: Thu, 03 Jun 2021 13:30:22 +0200
In-Reply-To: <8bc674-fcaf-8cf-55c0-678a7bf6af1@linux.intel.com>
References: <e553550a010387f7ccfafa4010397413b032eef9.1622042688.git.pabeni@redhat.com>
	 <8bc674-fcaf-8cf-55c0-678a7bf6af1@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-05-26 at 15:55 -0700, Mat Martineau wrote:
> On Wed, 26 May 2021, Paolo Abeni wrote:
> 
> > When the right bound check fails, warn_bad_map() reports
> > the wrong ssn value, let's fix it.
> > 
> > Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/subflow.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 6b1cd4257edf..726bc3d083fa 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -821,7 +821,7 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> > 	if (unlikely(!before(ssn, subflow->map_subflow_seq +
> > 				  subflow->map_data_len))) {
> > 		/* Mapping does covers past subflow data, invalid */
> > -		warn_bad_map(subflow, ssn + skb->len);
> > +		warn_bad_map(subflow, ssn);
> > 		return false;
> > 	}
> > 	return true;
> > -- 
> > 2.26.3
> 
> I agree, ssn is more helpful information here.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

I see this one has not been applied yet. Evil/bugged peer (or even
fallback with no infinite mapping) can trigger this WARN. It looks like
this is the only WARN() leftover from issues/107.

I'll send a v2 addionally replacing the WARN with a pr_debug().

/P

