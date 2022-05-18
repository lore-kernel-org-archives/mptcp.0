Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4191866
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 10:59:25 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id y13so2303019eje.2
        for <mptcp@lists.linux.dev>; Wed, 18 May 2022 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=atTHNSzf0ws075slN6B98a60LU+CrA8KMWRWnpO3Mow=;
        b=JpxQBU+4kuW3n/HBtWcJCtVltp8mtNJAWyQ0kT+JmwKtJIn9CKFF1NU0EXYGefvRtP
         kylmhiCWmgWxo5nWYiVlhomf+2HFa5I83b3AZWi/ErKU4L4imfgr6vGW+hLBd2Nv33By
         nnJ/DIDTu6RESHJptQS3JbKsjfWmHrwOjS4vzv7/K04HYLtrBu7t3hFfQjNNt/vAKeZn
         pZIZTG9PBxutuOAyFC8eCTaSZqIVraSuHAyhrfByrnsk4/fDOB60bgdZv2tfR20IUVBb
         ljRttaZIw1urfXOs/r/zTjGyboMrYcWXim8HWJC5anxphJWOwb3cHL3Bz3ZJ4nKzOdU2
         OUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=atTHNSzf0ws075slN6B98a60LU+CrA8KMWRWnpO3Mow=;
        b=SxKTRQeGjVlkj/Sf6320qHHyemKErvYYq7PmtoTucv5lkq8OJjJoV9OtBzyIbdQhRa
         AMepft3TNM1iC9s6AZ61yngXYxCcn6Ofjapu1MVc617/gHAaPuvd1n5s76TdEBFVnRX8
         /dG2QfsGm9llRdZlNI+PPBS/UEeu9onMJPd6oj3oZl9VbyB0GYhsxfob+uoXJ5E588jz
         6gvf4M+ns9v4eEBIo4F94VRHZZmc+GbLYXCQoWKCdCDg+1LRFmKlVVO969H/Dx5Mcw+O
         mm4Rg6pF7BA1gNnv54oig4esv31c0SsuX6PJ12NT5owUdXZ+JwYkvjQtgu6UgysuyxGP
         1BIw==
X-Gm-Message-State: AOAM532+Tk5UTjcY+hN+ltBlQyzLF25TPNvoFxpzr5m9TiAmkbCKk+Qs
	T9UXUepG9dAVX3o6iiFx1GN8l5Ua4EnnTA==
X-Google-Smtp-Source: ABdhPJyL9Ls/j0HBmgZEaDrQP+LIiv3x3sVggm95rtQw8dBWoLTfVePPOEW0gfo1bd0EFHUyl9MfXQ==
X-Received: by 2002:a17:907:728c:b0:6f4:57e5:9ac6 with SMTP id dt12-20020a170907728c00b006f457e59ac6mr23007338ejc.22.1652871563789;
        Wed, 18 May 2022 03:59:23 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8602:641f:1fd2:39f2? ([2a02:578:8593:1200:8602:641f:1fd2:39f2])
        by smtp.gmail.com with ESMTPSA id jz17-20020a17090775f100b006f3ef214e68sm786173ejc.206.2022.05.18.03.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 03:59:23 -0700 (PDT)
Message-ID: <b5db3ac6-acc9-a551-de50-816a79754e2a@tessares.net>
Date: Wed, 18 May 2022 12:59:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next 00/17] for bpf-next
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1652853898.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this series.

On 18/05/2022 08:10, Geliang Tang wrote:
> - The first 10 patches is for bpf-next v5.
> - Rebased the "BPF packet scheduler" series on export branch.
> - base-commit: df896c77f02a ("DO-NOT-MERGE: git markup: features
> net-next-next"), export/20220517T155019

Does this correspond to what I should get if I apply all the Squash-to
patch you sent yesterday?
Or are there differences on top of that?

On my side, it is easier to apply squash-to patch and re-apply an
updated series which is already in our tree.
Of course if the conflicts are complex, you can send your version on a
public Git repo for me to compare.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
