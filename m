Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD34A1F
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662734681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3FQUAR04E5wD2ikT1YjnS8Theg03sDrnd3VeR96pns=;
	b=Xoh9QV+LpQG/IHujmLUTSFCYuWQ/1bAYHH94/yG85ImOYghK/36gQ75spbelhjaIyrWzeG
	PrY1i1k8teOAwE48Txjz2yxJ2/yquh7JwMDYKDnzfPx+fN+hY4P95KpUYQfVKrPqQiGr2H
	IDWEGWfo+C5hdO47bbySwCso5hojUzw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-vroesAtVPLeAtVkuIq-qLQ-1; Fri, 09 Sep 2022 10:44:40 -0400
X-MC-Unique: vroesAtVPLeAtVkuIq-qLQ-1
Received: by mail-wr1-f69.google.com with SMTP id r23-20020adfb1d7000000b002286358a916so407432wra.3
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 07:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=n3FQUAR04E5wD2ikT1YjnS8Theg03sDrnd3VeR96pns=;
        b=HYbrtbALaN/DuN8EVMMTxdEad8A8Efoa+laPHAcKLpRyEdD5JXpZ9qVtHCJiznhqXR
         8QR+igP4jYpV5HINmtgAM+cSTyel/myeklLxKSF3k26/VumJQO636ssek7JFBgxtnR+m
         nwvUuPufnfcBY/A4Kt6vO6UV6pOMrKG0RGsg86O2FZ0spNn7td/uttiZ7lHO1WTSUrzO
         mRGWg86XIqAO3N3yhVRBIEEQYnsBknzvykoQiDZrllfZzGZN5JRqd2p3kGovXY9IMIuh
         JetndCKLHP+TNoES6HbVTBD5pnbYAJV1FHI7UgTPD78v4x5MQRAZLVLsfkKAfDBiChjn
         9rAA==
X-Gm-Message-State: ACgBeo3qrmL1G/a/ZBsMUKMP1FYXfFw4Ekh5HHWR/n+IYD3+NHFZlSrN
	MTUd8C/8SmDGzqk2NyD2oaZRkR5vEjurKMJ2UYhNXYLkYF7jCuQT2PDx/1leKZnNGnrkfVOUYH/
	VbBnemfeg6AlWK+A=
X-Received: by 2002:adf:fb52:0:b0:225:2ada:b741 with SMTP id c18-20020adffb52000000b002252adab741mr8430886wrs.56.1662734678670;
        Fri, 09 Sep 2022 07:44:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LdKodDTdRMLXTiuuNbvAS8pPAExkmBQJpvcZJwyzFqKpHyZFCBwM00IHO/cv7A2rb+bGgFA==
X-Received: by 2002:adf:fb52:0:b0:225:2ada:b741 with SMTP id c18-20020adffb52000000b002252adab741mr8430875wrs.56.1662734678437;
        Fri, 09 Sep 2022 07:44:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c284600b003a2cf1ba9e2sm896498wmb.6.2022.09.09.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:44:38 -0700 (PDT)
Message-ID: <99b1363eeecf160159bbe9f37e38221e93baef55.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] tcp: Add mss zero checks to avoid divide
 errors
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 09 Sep 2022 16:44:37 +0200
In-Reply-To: <48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com>
References: <48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-09-09 at 20:19 +0800, Geliang Tang wrote:
> If mss_now is set to zero when invoking tcp_push(), this divide error will occur:

We should not call at all tcp_push() in such situation. How did you
reproduce the issue?

Adding more check in TCP for the above situation is very likely not the
correct thing to do. Instead we should prevent MPTCP from reaching for
tcp_push() in the critical situation.

Thanks!

Paolo

