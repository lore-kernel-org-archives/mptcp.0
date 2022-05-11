Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8E28F9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 14:16:53 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so5062030pjb.5
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JK/VASr1wmm6wiz6PAiEGdEmp4ViEJ6w2D8vU3IHi8A=;
        b=ctVOAiWJzNHudb3ExVCUWFZsdiaJa6P1RtUPP6ZEHu7ZKnaUUekfNTGp09FSGJi+Yu
         takONmexij36Oub3OBqLLLq+8NZu9jYgL8LRAbxRNlGr5BlDvkMflPMOTcJZd8riSV1s
         7G2OmiUTKseOoHa7OO6tmvHF74KZ95ShEm+d9zeQooF6r2hX5C/JwiLOl/zmYVUOUo2G
         PbOVHHzCIDDnopeXzM0eu9i0yy2+u60GKyhN76hggzMxYay+4EyRUuEF+WO1TDA9tiMv
         FRkQJIkMSehkvDKILKr41Ejc5NfXUCfi2MwmzAycEl0S0fr9xIXsUquMI5MtRHuE4eMt
         LEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JK/VASr1wmm6wiz6PAiEGdEmp4ViEJ6w2D8vU3IHi8A=;
        b=5yevP/vMZuh2LoHqIm/+Wo+wCvYfKOHxDMkbNTWXf8UsLJSLlNlJd3PnIwM11DeJ1J
         Wo9IqncTjKVModkX4VDPZxSvB3BudSFEQ8M34BvrEZzlz1cw1/MsmjeQzrCVbUVxIIG6
         NtJtaG15As22K4/rKQgoU3jXa00+y2CdRJMuv1bVKz0sI3ahFILG0AW5Un1W21C0W6wK
         uNVTihRMZ0Ymb6u50ua6l07DqPe2jOm3uKoXI0OHSJZLzeI02ZpYaEyB37q22cl3Zrrt
         0Selb52KVztsK9gihRMdAgnoTSoplc0jQTlZ6zqNREC6OYCt3N6ymAMCBI8vaL1l4SV9
         YVuA==
X-Gm-Message-State: AOAM532AiNDjA1ubQagVt+MKYAxKpXtJuRr7XWUOv9HqPdTLDgwF06j6
	QeQXF7n8xDfk57mgovmBVwgreLvopQz8PCZ6z0E=
X-Google-Smtp-Source: ABdhPJws1FuGgK81/Ut13klF+uTvvwdc5MV347lceBIBRw4wBDOy1rLEmxjh8LBaYj1ms3T9MDeTeL2mC6bBv5PnJgM=
X-Received: by 2002:a17:902:be0c:b0:15e:eb8b:bca3 with SMTP id
 r12-20020a170902be0c00b0015eeb8bbca3mr25135865pls.25.1652278612795; Wed, 11
 May 2022 07:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>
In-Reply-To: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 11 May 2022 22:16:50 +0800
Message-ID: <CA+WQbwv+qDJUFSSSvSVXg3qs7tbyzkEZPX8xxzNNfZP_pw-5ww@mail.gmail.com>
Subject: Re: problems with MP_FAIL timer
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=89 19:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> re-reviewing again the commit:
>
> mptcp: reset subflow when MP_FAIL doesn't respond
>
> There are a few issue with sk_timer handling, specifically:
> - no additional mptcp_data_lock is needed to stop/reset it
> - I think overlapping infinite mapping reception and close may lead to
> some inconsistent timer usage
>
> More importantly I could not find the RFC reference for such
> timer?!? @Geliang, @Mat could you please point that out?!?

The timer isn't mentioned in the RFC 8684. It only mentions MP_FAIL
should be sent back here:

'''
3.7. Fallback

In this case, if a receiver identifies a checksum failure when there
is only one path, it will send back an MP_FAIL option on the
subflow-level ACK, referring to the data-level sequence number of the
start of the segment on which the checksum error was detected.
'''

Thanks,
-Geliang

>
> Thanks,
>
> Paolo
>
>
