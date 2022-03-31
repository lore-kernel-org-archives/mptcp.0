Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC311A2D
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 18:24:06 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-d6ca46da48so119525fac.12
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=yesPU3SDbBcDd4ReUs2XnnvnmEg173VZaD473ojDehs=;
        b=J0J4NOhkg5bdBbJzCSkDU3m/kcPRAx/ko4v97JVuN4KBTzB/lk09drXtP1I/evhksb
         xsV2nY9EAeb8Ck2LhWxR8B8WthLKZpw17/jwnhgvyz7909q7HG5E3603VxBoZfeKk/Ce
         HuYrn19XwIBo56eNMiglhWbZrLs4+e4Eu3If6wNWMyCg9NksCFQAIxhqccxLIA4RK3zX
         Kp/d13W+xfe21KjuwkZo+gi332ipskuoFBU7Ap4tQYrK2mq4KnPu90aLe4+MnQbUCd3u
         MbntmJtzDx4RVPVHITbwv8RgUWaYpqbz8uBzsUXV6CjMIK1cl5eV/WlmqS7ZEXIY8EU3
         1i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=yesPU3SDbBcDd4ReUs2XnnvnmEg173VZaD473ojDehs=;
        b=6lAfUBrE5GHqdcEmq+Qi4j6/wanJR3OW0bYXx9K3aTZAb2s+o4RmUe4wGZwOotP9vp
         r3hxL0QJEM1iCzlSskZvF54boIRBH529jlASszY6Ur4yAbq3Ny3xOq1pLEPMOukQX5e9
         PhS9t3/EcM48vVAJjj/RDMJgzRZh2klYZSlcVy1sFimufFo8/U4Bu9p+EBQFg9wIsEMX
         ZOUmHLWVWZ5pGpUlRrhqqbuJL+s2LKowmHmEpVoQeYglvoAPUUOf5bC9i4pvYBqQRsDG
         Y22hpa3ysR9eu/JrMrGAA7yEoiZZDyEtiFM/gvLDLGvCfDpK5RJeIZO7ktp5IUUzd6j7
         yoUA==
X-Gm-Message-State: AOAM533viXjif3cRNPet+nAyEA2uLAcvpVTcQGFGgqnTxc9JqQiiPV2k
	wsDqM4XZxwrC62KCqgVpU4E=
X-Google-Smtp-Source: ABdhPJyyuVXBByD2St086u49lFqjEA8VvNAkZU4nudV0TshbJkvbacrg8Xqt6md4gM11vi23Y4VtfQ==
X-Received: by 2002:a05:6871:728:b0:dd:c167:4393 with SMTP id f40-20020a056871072800b000ddc1674393mr3314045oap.108.1648751045900;
        Thu, 31 Mar 2022 11:24:05 -0700 (PDT)
Received: from [127.0.0.1] (187-24-193-62.3g.claro.net.br. [187.24.193.62])
        by smtp.gmail.com with ESMTPSA id fl12-20020a056870494c00b000ddd5a37614sm61964oab.8.2022.03.31.11.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:24:05 -0700 (PDT)
Date: Thu, 31 Mar 2022 15:23:01 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Andres Freund <andres@anarazel.de>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 John Garry <john.garry@huawei.com>, mptcp@lists.linux.dev,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
User-Agent: K-9 Mail for Android
In-Reply-To: <20220331173344.xvhp4yi67fv6p6t5@alap3.anarazel.de>
References: <20220329093120.4173283-1-matthieu.baerts@tessares.net> <20220331173344.xvhp4yi67fv6p6t5@alap3.anarazel.de>
Message-ID: <5B37F7F6-CDFD-49B9-9BF6-CEA726E5F0CF@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 31, 2022 2:33:44 PM GMT-03:00, Andres Freund <andres@anarazel=2Ed=
e> wrote:
>Hi,
>
>On 2022-03-29 11:31:20 +0200, Matthieu Baerts wrote:
>> It seems it cannot be assumed =2Egit/ORIG_HEAD exists if =2Egit/HEAD is
>> there=2E
>>=20
>> Indeed, recently our public CI reported[1] the following error when
>> compiling Perf tool:
>>=20
>>   $ cd tools/perf
>>   $ make -j4 -l4 O=3D/tmp/(=2E=2E=2E)/perf DESTDIR=3D/usr install
>>   (=2E=2E=2E)
>>   make[2]: *** No rule to make target '=2E=2E/=2E=2E/=2Egit/ORIG_HEAD',=
 needed by '/tmp/(=2E=2E=2E)/perf/PERF-VERSION-FILE'=2E
>>=20
>> This is because apparently[2] Cirrus Ci uses a Git client implemented
>> purely in Go[3] to perform a clone=2E Most likely, this tool doesn't
>> create any =2Egit/ORIG_HEAD file but =2Egit/HEAD is there=2E The error =
can
>> indeed be reproduced by renaming this =2Egit/ORIG_HEAD file while keepi=
ng
>> =2Egit/HEAD=2E In other words, it means it is not enough to check the
>> presence of =2Egit/HEAD to assume =2Egit/ORIG_HEAD exists as well=2E
>
>FWIW, It's not just custom git implementations, stock git doesn't ensure =
it's
>there either=2E I build a nightly VM image with Linus' kernel for postgre=
s
>testing, and as part of that I do a minimal clone:
>  git clone --single-branch --depth 1 git://git=2Ekernel=2Eorg/pub/scm/li=
nux/kernel/git/torvalds/linux=2Egit /usr/src/linux
>and then build the kernel=2E The build recently started failing like this=
:
>https://cirrus-ci=2Ecom/task/4648999113195520?logs=3Dbuild_image#L3121
>
>It's not a question of "--single-branch --depth 1" - ORIG_HEAD just isn't
>there in a new clone=2E Which makes sense, because there's no previous va=
lue for
>HEAD=2E

I merged the patch that stops looking for =2Egit files, as soon as I fix a=
 libperl feature test with CC=3Dclang I'll send a pull req to Linus to get =
rid of this =2Egit perf --version related regression=2E

- Arnaldo
>
>Greetings,
>
>Andres Freund
