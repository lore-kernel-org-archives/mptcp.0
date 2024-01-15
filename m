Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3818622
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRu55eff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705342419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mjLe3zbNHd0mtoAotfkcvdUeZ+cL3L0kJd2f0AU9Ep4=;
	b=cRu55effg2zczHCxpg6SzQK9jl4Majwoc4k5cLq7ueq63918LNfp6MVGUknRTiB/9xptPv
	8k3uWbw0p42z4ZQJAGPKgYfLyT82AzI9O9j+teTjt4gNtT88SwoMp5K0Hw18SKkiXiwN+K
	8HDwZ5ARaSuBw9HTR2LjuzxFYOOGAWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-0IRqtK0cNMOrmCq3VofMlA-1; Mon, 15 Jan 2024 13:13:32 -0500
X-MC-Unique: 0IRqtK0cNMOrmCq3VofMlA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3379f55a7c6so464780f8f.0
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 10:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705342411; x=1705947211;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjLe3zbNHd0mtoAotfkcvdUeZ+cL3L0kJd2f0AU9Ep4=;
        b=J0zUrK6zmPrSRPyJvOtxIulG+OmEzQkjCO7YKNztXRzY2sZZGDRT8k73E7cma6N4Wl
         N7+rHGYKbh3BN5Bpt9ZIQZX1WkmXBqo798keO8fN8+VpYyOJ45DE/9KlVu+UBJHcclbS
         lJE3dTvV2S9dGorGJsH+yiD8IrcgCaaRXx0kFfAPzQnQYFZqW3uRnSsfQb4hNcE8hTjT
         nL/ToTrbWx4sP13+4ko8SuRgAndkcJm4nBydgOCCzAk5HprkL5hoykgsMV8m6zzuci0a
         tzeR12f22hKecwTY94e2mcD/6TAjJnDZqs2N5kdTyDR17JNtnfxPHBtfYGuSZD0RYjVs
         FIbg==
X-Gm-Message-State: AOJu0YymsnYA9lv81F/1dF0xeVQLqolEenQeeVu7eepNtck6wr7de55l
	AZ7qQa7K3Xl+dIdGrcIMJnLTNGcrF8dihQD5v6chTl/LSXxGUabUs2DUTV02xvNjlNNjJVh6BRy
	c5Fni4R0r/0BtByVSg+HZp1uMskljrrA=
X-Received: by 2002:a05:6000:1c1:b0:337:476f:9964 with SMTP id t1-20020a05600001c100b00337476f9964mr6810590wrx.3.1705342411610;
        Mon, 15 Jan 2024 10:13:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDi3/pYdjMgK8hq8gaMHEuJXWCUzhObxZtwm9ILvDQYYEwmsNcfn2U0CKDOMA8qTNTIRxFhw==
X-Received: by 2002:a05:6000:1c1:b0:337:476f:9964 with SMTP id t1-20020a05600001c100b00337476f9964mr6810576wrx.3.1705342411236;
        Mon, 15 Jan 2024 10:13:31 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-231.dyn.eolo.it. [146.241.250.231])
        by smtp.gmail.com with ESMTPSA id j27-20020adfb31b000000b00336e32338f3sm12607337wrd.70.2024.01.15.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 10:13:30 -0800 (PST)
Message-ID: <f8dbe390e3d69d31111f5294c071e444e3d3d4d8.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: relax check on MPC passive fallback
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 15 Jan 2024 19:13:29 +0100
In-Reply-To: <dd789fa7-b777-41c0-8891-ffb83502e97b@kernel.org>
References: <4d9707b72d37cec9b4b6725bfcf3ae03010e0d51.1705330501.git.pabeni@redhat.com>
	 <dd789fa7-b777-41c0-8891-ffb83502e97b@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-01-15 at 16:52 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 15/01/2024 15:56, Paolo Abeni wrote:
> > While testing the blamed commit below, I was able to miss noticing(!)
> > packetdrill failures in the fastopen test-cases.
> >=20
> > On passive fastopen the child socket is created by incoming TCP MPC syn=
,
> > allow for both MPC_SYN and MPC_ACK header.
>=20
> Thank you for the fix!
>=20
> > While at it, additionally allow for real OoO packets, as the RFC
> > mandates.
>=20
> Should this be split into another patch? (it is not a fix for the commit
> mentioned below)
>=20
> Also, the comment just above the code you modified seems to suggest we
> should do a fallback if some DSS are detected, not the opposite, no?
>=20
>   /* (...)
>    * Even OoO DSS packets coming legitly after dropped or
>    * reordered MPC will cause fallback, but we don't have other
>    * options.
>    */

Oops, I forgot to update the comment.=20

The point is that we should be able to accept OoO DSS packets, and
switch to fully established when receiving the MPC_ACK, but I agree you
are right, that much of change is dangerous, let's just accept SYN &&
ACK and ev. handle better the thing later

I'll send a v2.

Cheers,

Paolo

