Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A73239
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:40:02 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id i12so9612842qvs.2
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+I1oxAvD31/IlBKlerTofwrgaXKxoHT6eAaDjLxrkY=;
        b=KxFp7qOvZCNrgbAn+7K7zznw7OGzEmfgDOEyTmmZp20xsYtCCOwkW3iKZNig/CY6kI
         W3rD7KRgMPD6MWh1whOVOT8tztKXKzw+hiGpTrHoV9JpmAVPTO1Kp+Piis/FcW25g3tQ
         Wvh0G2tnw1bAdNrXQuAYoVCuvqbkWQRm7UQ/bh6db7WxsWcrqH3xmvlOHIxvJLZn5RkU
         SCs6Hiqi2+PoWeM7tt4MKHoaNDA0BiiYhg2quT+qSdqgaKx6PPN671PI6FdrSCYKViof
         HzEtNe8YTCXErIbGIQn7BLce6oK8Yx3WKGG6FvxiP5JVUHBuxK3s16KI9IAaBiqVFOs7
         2/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+I1oxAvD31/IlBKlerTofwrgaXKxoHT6eAaDjLxrkY=;
        b=SwcebK0rNSreTvRRrEfd7z/cQPHheYQTgt3zuEFfxq3szUzDQckYJtOvUMajrohRwD
         zpBU64GxycYLWk0/mAK0RvUmjQOb0OVwP171d0KyACCauD/40NdG6IcWWuD5nehrudRY
         U53iDOMFXWQp95R+sAtIy/w7UK1Mb0ItEZ1CtLR3KtwXVwXqVrVfnEJWw1yxfIHVPcgT
         mgz/I+tgrwrMmC+3d8mORAqeVLpaAKAQMxZmIR4GghP+lyA10QgRc14P/7ljMZmi2qjV
         ltcud/nPpz77GQXbtFsUT7BvjIk8bgKVMkTAT7MzvGHVLtHNRuEB5eNHnUJcXyEK9XpI
         iE1Q==
X-Gm-Message-State: AFqh2koRtrkkCYZWWsaVeUgg2+COzKPnPfMd7uwdOevgQzJkDHQhr9pN
	uMsOHAvz5eGfQbYH60wTsUb/TUvHLg==
X-Google-Smtp-Source: AMrXdXvj+Os9yyJSmohuXzKxveDAi/5ouxh2I5Q5DCfBvMoqhQRZRdnanAZD39ldJDEV6yJBWhJ/WQ==
X-Received: by 2002:a0c:bf02:0:b0:4c7:53b0:6df4 with SMTP id m2-20020a0cbf02000000b004c753b06df4mr41337090qvi.19.1672166401074;
        Tue, 27 Dec 2022 10:40:01 -0800 (PST)
Received: from [127.0.0.1] ([52.226.126.224])
        by smtp.gmail.com with ESMTPSA id r30-20020ae9d61e000000b006fcc437c2e8sm9702887qkk.44.2022.12.27.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:40:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221227182057.2288816-12-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-12-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: userspace: print error details if any: Build
 Failure
Message-ID: <3247736b-bc01-16f6-7e88-24470e3f0b5c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Dec 2022 18:40:00 +0000
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
org/project/mptcp/patch/20221227182057.2288816-12-matthieu.baerts@tessares.=
net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3789259=
951

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2729de9466c

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
