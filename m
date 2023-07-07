Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88C1FA7
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:25:10 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-79470b88d88so792338241.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688747109; x=1691339109;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF5JLI2JLysWIuy/tz4ubpyJxGQiAIGYRFR7avCjkvI=;
        b=SpdUHkESsrWRha22a/7tu+kqnee30j1SL9DSbZCrATOeWBeCzjSD3OxI0wTrm2x25A
         4ujIzeXzIHDSoaHOZCqdAh5Ev3pyoSx5B+M8CSLZ8rQFeK+i11mlZbXLMgjF7FTyryQ5
         iaJrsOzKcygCnkmm1pw3MJgbnqZ3S127w6sEEK23nELgeNnOKDV5imApKLlYeMX5LLmY
         flOyS57i20pz4PZmhbSTVDNc47/GdnbCqqnL7j0/dqFrsqg6E0YhTgUf8+dLxi2MxiDg
         36+PejmmJPTidmxOqDBtDTbO5FrfF5uiUA15B4avXlQ3OEkpyfnMzr2ZIaH04aqK9lBo
         X4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688747109; x=1691339109;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oF5JLI2JLysWIuy/tz4ubpyJxGQiAIGYRFR7avCjkvI=;
        b=XHiFgRuijy6NXlXtd0IT/4Wm+soC7bhg/2N7IdmqEJBH6qDBXH/2OX8IVzrkHnuCre
         9OeeXYJ0a5mc2hpCaVnUEuAt5oiiE9e0CB+Qx7h25umVueNBnWMDuVdGA4hYBhiw80pf
         7fiumbUm7eZKQWAdRTXzfS3miJwwIdK7nal7NnOdhd/buLdXjVyQZ1d0dbElUP92vhnD
         rYuU6+t1SkE5M1Au8VnZIPrL7vx+SCx+n1iv2hjtoeojzXB2ulrubv6UhSt5LAFRn3q5
         JlG+i+beW7OwWrDgj4vBtJ0FcMOCZ8WOdnN/WsaL7hAm4rTtKYnbPQzSzFSgJEDNVjRH
         /Hqw==
X-Gm-Message-State: ABy/qLbVzDktuhoUxQcWDv5PUMygCOqbCunlKOV1tU3MZQbw5PH51UU+
	dPE31gVmxwdeRlYkr1oPba9bC1/peA==
X-Google-Smtp-Source: APBJJlHq6a23jRqzZLNjFTthKIOUebZLEAySwxTsuBdooxxxe5cL4VCR8+MFDsb//JkX/OZVYlSJ4g==
X-Received: by 2002:a1f:ddc1:0:b0:476:4267:178c with SMTP id u184-20020a1fddc1000000b004764267178cmr3344278vkg.13.1688747109264;
        Fri, 07 Jul 2023 09:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.119.50])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a11b200b00765f8e5ac83sm1959736qkk.53.2023.07.07.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:25:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
References:
 <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
Subject: Re: mptcp: sockopt: support IP_TTL & IPV6_UNICAST_HOPS: Build
 Failure
Message-ID: <75309790-cbf3-b424-3e35-e850f94ec5bb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Jul 2023 16:25:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c=
06646@tessares.net/
  https://github.com/multipath-tcp/mptcp_net-next/actio=
ns/runs/5488425457

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/25067ce9c1=
70

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
