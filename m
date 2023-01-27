Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15666187F
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674844350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfRiBKMpu/uYDD/uCxUYL7dCpQJdIHfbJvWp+RMk4GE=;
	b=PH08SPilWqqCAmRNIOjJ3VN/nOm34/qyvVUXxpfjJ6DUFkg6h0Rbq3AY4tG1H8GDsB+YYu
	cfw+0pXFyUdga9+jkdCSohzDWNYV1zteqWa89s84511ShI2p1Y39/PSuAuXPmotWy53TrJ
	oiNVTgZ84jV1i5VnCdTEMxm2QFeUxFQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-444-2gFDvyoeM5SuGB0U5uQXjQ-1; Fri, 27 Jan 2023 13:32:29 -0500
X-MC-Unique: 2gFDvyoeM5SuGB0U5uQXjQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5062f3a2977so64613417b3.21
        for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 10:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfRiBKMpu/uYDD/uCxUYL7dCpQJdIHfbJvWp+RMk4GE=;
        b=vwIA8/Q7TE8t6touIKjE1Re1YkEisN2A9L9A2Fd4QvYdfNJE96lY0O1K1ud1GYM52g
         jYPYiQPghfu3FUbqNfqUIkk2NCd5c5fjgYt2Bz4xxfaiFMMFo4TBs5exKxkmvQEBs7zI
         jnFzqu2F9/+zaVyPUB8ngv2zOM33ByskCMhnFNCEjKnTFr2BH/ixzKIFFOPyHJCAdSeX
         JAqGcwdRYKde8XodmFSOodFiW7VOyqucYDeU2mq9XS9tFVuZ3IdigE7deN33AokNPyJM
         K8kBY3Qv2l5x4DO4hAIoD04HLcbuPxl8HzKVaISM/g73pSi3qiToW9nTwNalZvsjoqyM
         PePA==
X-Gm-Message-State: AFqh2ko5fXQb/H73oMsq8EJSCmQ0vQBa9pprnRjpYWz/0utock3XCwgh
	RVJFPH4SWeADVCNX+PKerkpleeqio/awFsYX2Ib0KyleX7ZNTq0JP02tLlUfZljwXWbicpJNa49
	MQoyEeSUR9dTfdUZ+a9neIyst25AQVw5urvNS5g6pU4ik0yluDyPedQm6mdfjLzLW
X-Received: by 2002:a25:4d03:0:b0:7e4:b04d:9eaa with SMTP id a3-20020a254d03000000b007e4b04d9eaamr27596085ybb.34.1674844348224;
        Fri, 27 Jan 2023 10:32:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv70tZ1vitYgUs0Aqz/GDuLEsubMJomNf8beZhgNhDLcHBDXH/kDtP3095BNsfy/rY0UEi6TQ==
X-Received: by 2002:a25:4d03:0:b0:7e4:b04d:9eaa with SMTP id a3-20020a254d03000000b007e4b04d9eaamr27596058ybb.34.1674844347872;
        Fri, 27 Jan 2023 10:32:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id p3-20020ae9f303000000b006fa43e139b5sm3275666qkg.59.2023.01.27.10.32.26
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:32:27 -0800 (PST)
Message-ID: <fec3ae3746f646f7738b5169b2c13fb42968f0f8.camel@redhat.com>
Subject: Re: mptcp: do not propagate fallback subflow status on error: Tests
 Results
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 27 Jan 2023 19:32:24 +0100
In-Reply-To: <d007c301-f185-bf39-4002-be1b55073562@gmail.com>
References: <97f7deb4132d567132088d43f3e7f5ff0602a45b.1674668294.git.pabeni@redhat.com>
	 <d007c301-f185-bf39-4002-be1b55073562@gmail.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
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

On Wed, 2023-01-25 at 20:03 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> Our CI did some validations and here is its report:
>=20
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
>   - Task: https://cirrus-ci.com/task/4694040256446464
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4694040256446464/=
summary/summary.txt

It looks like we still need to propagate the status for unorphaned
sockets.=20

I'm testing a v2 and I'll send it out soon.

Thanks

Paolo

