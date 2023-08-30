Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A623DF
	for <mptcp@lists.linux.dev>; Wed, 30 Aug 2023 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693409409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqOyL3SdQXEq8HuRau0O5bnjaOwsQUNq3nMS9B+/teQ=;
	b=NrXgWqZVTmFFFdJ15uZ4lAuj7fzhU+cH/hiw9DcfA4snR+tFfm+aOvXblRA2s6X7/IoqlB
	zmSS/kWqAA3tCmIXwmWaAvnQwjsNsT0rMG3MCH1dSl27AH4rHD9p1VcWFfYiQc1U7StSZ0
	jh4LsKEKKHN40sIdNzK+vPJGU4CrppA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Qjq2a389M9GTb4JvWOQ-bA-1; Wed, 30 Aug 2023 11:30:07 -0400
X-MC-Unique: Qjq2a389M9GTb4JvWOQ-bA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso19827951fa.0
        for <mptcp@lists.linux.dev>; Wed, 30 Aug 2023 08:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409405; x=1694014205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqOyL3SdQXEq8HuRau0O5bnjaOwsQUNq3nMS9B+/teQ=;
        b=BgYUeEQismsarl/8kob9FgeH2l5tiZGjy37ptwvOr9NPw4EAIF8ZIRhDyOskccHS8c
         fuYRN//bY0w7q0rw2Ah0n3LVZMy6aPTw+Oz0JqdeGz5gkJ6M/5jOXvC5NP+Xf9M+36vR
         F7EiGxVRS7dUnnGD6G0O3AaMnAFLBNEYNKs9Ia2DMsJmSUiw8pzRAC+qB39XbgTFGUo/
         r0Yii7gKIrbXNHxcGKKO/Kv3tkHlPK/CdvKJOhrjCcaAMmb+6OSwWi5JeoG3Ozzo6pAC
         6wy+enGIrszZAIc0zLMiezISClIftY23U/+77pJ3jxleE4QnSOF4qheYkvpEyk2xD/W6
         aBQg==
X-Gm-Message-State: AOJu0YxI+tvFhFT5kJ9PfDE54lS3TUq0abySgnB0syhu9GneP8ZVbR1w
	5CJ+9b7o8yuHtpSgZuKm5mSRzUuPE5n1YWSGN2ma1zR6ql9vllNiHFzb3KOBHN6aAzOspLxmVHf
	dNsCcbk6t5+uv46YjCRPYylgAfEnE0IX+7xxQ5Ti/Z9BLLwxkffgh9od6c9KPNfrzqbj4jJoU
X-Received: by 2002:a05:6512:4888:b0:500:7c56:ff5 with SMTP id eq8-20020a056512488800b005007c560ff5mr1879648lfb.0.1693409405424;
        Wed, 30 Aug 2023 08:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg3cwrm18HgJOqya8nohm1nDYS15zeuH55IIObAQXb4ajOIG/rUWB23HCrWUN0WlnfmJx7Cw==
X-Received: by 2002:a05:6512:4888:b0:500:7c56:ff5 with SMTP id eq8-20020a056512488800b005007c560ff5mr1879632lfb.0.1693409404998;
        Wed, 30 Aug 2023 08:30:04 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b009a1a5a7ebacsm7247261ejb.201.2023.08.30.08.30.04
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:30:04 -0700 (PDT)
Message-ID: <35899ce3c7da124edf89b8e74dd5c95b4863dea3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: fix another close hang-up
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 30 Aug 2023 17:30:03 +0200
In-Reply-To: <cover.1693322440.git.pabeni@redhat.com>
References: <cover.1693322440.git.pabeni@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
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

On Tue, 2023-08-29 at 17:39 +0200, Paolo Abeni wrote:
> If the TCP subflows close silently due to timeouts, the msk socket
> can hang-up indefinitely.
>=20
> Implement an additional close timeout triggered with the last subflow
> close event and move the msk to TCP_CLOSE when it fires.
>=20
> Should address issues/430 and issues/431.
>=20
> v1 -> v2:
>  - fix timeout timer scheduling in patch 2/2 (timeout never fired on v1)
=20
As per last Daire feedback, even this revision don't fix the issue for
good, so please this series on-old.

I think that at very least this does not set/trigger the socket error
at close time, plus possibly we will need to make the timeout
configurable.

/P

