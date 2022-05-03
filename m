Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611707F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 16:35:37 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id t6so24153576wra.4
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LHl3/B/QeH7yOznm8iqzsNr8LfSdQpYBrrUewHpoVRM=;
        b=JPS1MfWI5gaHVRETd+kKoLDFY6f6VO0cpfIqdtK/P10VxI3jwflNnvmQbGzKyXihJz
         sNcgsQUfaIC1UaUdh5Qtwtb7d6O5IFuW2cfE79N2WODBNSp8omNJSfRmWLcbwemNx4d8
         ulYkO61Tg4a7Z5GB8R2zkBAwFkazVg8w9AYKALHdIt3+9jwVGTOOEJ64OCh0bYL0NyU3
         l2toaI1t0TJ8oUVdy5Jp7OqGGymT59kMo5oTFgSWSVDjdQnuACx0VTY5qZPGP5kxwxJS
         AZwZmlUlhBQvlcS+wx0xYPF79xDUDI7iCJxavAJpBZ7b6ImBl7AzfWun5DZhyeZM4CoJ
         bKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LHl3/B/QeH7yOznm8iqzsNr8LfSdQpYBrrUewHpoVRM=;
        b=ToHld0OqQrZDOyuxnb+pK8X+HUO5squlgS7Gi8AyREzh1EihaSj9Xo6lIg3y7OWvOQ
         0B3DU/AE7XaIonJUnRojZ8IROlOnEJw0Ds2ENpTFEpeM4LvpYc1T5U8b0egRvgRZ8aw5
         jx6P1d2OADTPsqp0NO1HZe66vGdEayqBj81rHs7iB0ZMYogOMEdQXen1bfPsJfk8JoTW
         nLGdCtXBYNhClBsmupZLb4K0GZK4C3WwnIbvnZNJr0hpU6Y8nTR6RRmqm7iWxOneUnLW
         4QP+sPZl4mfYnxgpJ4nUdWY4ngv7poeaOLpuEb2YMukQoRvfgtJf6P3bhRgJhAEqBSIM
         g1aA==
X-Gm-Message-State: AOAM531w2aYZE9YMsxN6Z7KpQ5KMks1Am5cRf4VuBYO/FF3fnT91ruhe
	RM/J+Z2OwPcxaOq4Mi+Pl+eaLpxUjN1uHQ==
X-Google-Smtp-Source: ABdhPJwocNSswBDCA2gx3RMVOgXP+HISOm+BcG3Jg3GbDcUDdsQ9kjZFHV+TphJ9sWGST2Ajpu2igg==
X-Received: by 2002:a5d:62c4:0:b0:20a:e377:71ea with SMTP id o4-20020a5d62c4000000b0020ae37771eamr12895366wrv.549.1651595736271;
        Tue, 03 May 2022 09:35:36 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id c3-20020adfc043000000b0020c5253d905sm12178217wrf.81.2022.05.03.09.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:35:35 -0700 (PDT)
Message-ID: <d4d2dca7-bf7b-c45c-ef1d-d8878465cf24@tessares.net>
Date: Tue, 3 May 2022 18:35:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix a mp_fail test warning
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/05/2022 02:19, Geliang Tang wrote:
> Older version tc command (iprout2 5.3) shows actions in multiple lines,
> not a single line. Then the following unexpected MP_FAIL selftest output
> occurs:
> 
>  file received by server has inverted byte at 169
>  ./mptcp_join.sh: line 1277: [: [{"total acts":1},{"actions":[{"order":0 pedit ,"control_action":{"type":"pipe"}keys 1
>          index 1 ref 1 bind 1,"installed":0,"last_used":0
>          key #0  at 148: val ff000000 mask ffffffff
>  5: integer expression expected
>  001 Infinite map                      syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                        sum[ ok ] - csum  [ ok ]
>                                        ftx[ ok ] - failrx[ ok ]
>                                        rtx[ ok ] - rstrx [ ok ]
>                                        itx[ ok ] - infirx[ ok ]
>                                        ftx[ ok ] - failrx[ ok ] invert
> 
> This patch adds a 'grep' before 'sed' to fix this.

Thank you for the patch!

Now in our tree (fix for net-next) with my RvB tag and without the
iproute2 typo:

New patches for t/upstream:
- d691758ed81c: selftests: mptcp: fix a mp_fail test warning
- Results: c3f5d94e8dc4..9cac72edfb62 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220503T163309
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
