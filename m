Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981212C9C
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642524525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WdyrW4kwQJp5EMVJI0SR6OOwUnkDUqMSE8xWAg251j0=;
	b=PiRV45H/1aWsKClK6udPjFKQeJM4CJWO5TAGK0QhXZb/3L52qkLrlZSrueV2pChj6qpenx
	x0l9eeoylf7BE1DbhaCs+i+JtiRyq2I8lBJbi5ocEXZtlkkeo0jxYorfQ266sWUXZRViue
	Dc2fHpsr/6VPMg2YpoUqeuPKHL0D9j4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-tveJvm99MZiS69T5ZTiysg-1; Tue, 18 Jan 2022 11:48:43 -0500
X-MC-Unique: tveJvm99MZiS69T5ZTiysg-1
Received: by mail-yb1-f197.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so487234ybg.8
        for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 08:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdyrW4kwQJp5EMVJI0SR6OOwUnkDUqMSE8xWAg251j0=;
        b=YJao+OXaMarUPKkCFwuvuxRLIAg5DZ95UzJcRKxEksNsQqGeSPisv+Xzc8Ece+aSAj
         Ibu5eVxzqtyoJNgrBThI6ppqVfdONXTcXL6fO42RnnHS1d2OUzyohJmzFNWvpWzspEHu
         emOWuLXOh+SCVozjzviAMOBUyGxFKahMPqJl5NXgSYSM+8ruClWu/q0S5RvsP9k/wL+b
         T+GOJ3ii82GsY39aPxEzcodVqYhcuX3h9bXWTBofEEy8htx9wQPuf6QLxgWf7EdcWvVT
         SbDair+22pkA6x8SjqAm9O4yW1XuXBjUBZYmaLoA34ZwwPZZwlChu1ClqJ7BgnRiDtp7
         BUUA==
X-Gm-Message-State: AOAM5336yaFCLx5ERdwSYGHY5xLCkSJqd/6tn/BHC4DsSbNmGS8uIMb/
	4FgP9Xne6UNnuz0mr5Js+WAqWKF4Wey2SPIPnjJlQZhtGFkeKbzRwHEkZBZwI9UT9hhuzZCyHAK
	K1NJgLX17kTUFNjKoITgtAghXwH8NPgc=
X-Received: by 2002:a25:9246:: with SMTP id e6mr18524227ybo.636.1642524522883;
        Tue, 18 Jan 2022 08:48:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVpdKWMSyExXLT2qkuhP4a6vHWGdTAHuQo+gAqIZbdC4/LP0Eo5gg8I2Kxa4t8CG+fSLDZo0YFLpgCVTfRppU=
X-Received: by 2002:a25:9246:: with SMTP id e6mr18524200ybo.636.1642524522640;
 Tue, 18 Jan 2022 08:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1641804767.git.geliang.tang@suse.com> <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
 <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com> <a1679740-24ed-c788-46df-ad195068dd37@linux.intel.com>
 <CAKa-r6sgL1UUES5WYryNYedLJuq0_dEsO=X1263GFPOExci6BQ@mail.gmail.com> <eb7a9238-6fda-761e-23e9-47fbe332705f@tessares.net>
In-Reply-To: <eb7a9238-6fda-761e-23e9-47fbe332705f@tessares.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 18 Jan 2022 17:48:31 +0100
Message-ID: <CAKa-r6t75QbV-BE3rKvUHVCBYmcO1eW2typSFUgPSA34uDFEPw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail testcases
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 18, 2022 at 3:15 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Davide,
>
> On 18/01/2022 14:32, Davide Caratti wrote:
> > hello,
> >
> > started looking at this, but the wild-guess is that the problem should
> > be fixed with [1]: I'll do a quick test on my VM now.
> >
> > [1] https://lore.kernel.org/netdev/20220110094750.236478-1-eric.dumazet@gmail.com/
>
> Good point, it might be linked to that.

hello,

confirmed, the problem happens when kernels are built with
CONFIG_NET_NS_REFCNT_TRACKER=y and the problem is fixed by the
above-mentioned patch from Eric. It can be easily verified also with
tdc kselftest:

# pushd tools/testing/selftests/tc-testing;  ./tdc.py -f
tc-tests/filters/tests.json ; popd

thanks!
-- 
davide

