Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF572
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 14:39:34 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id og14so4921007ejc.5
        for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EL21QfEsF3+PJl4EwgnGamYd1DQ9r89UbV2SxaWpqOo=;
        b=hB9bGhYkf1a40HDNlXUHSMvS94i1QJAyOhagWTwVrz7dZH7SJM39bYQX6R/+rax4bM
         IaW14pN6YQb8ZF3nrvIYETNAfImBbXinVRrM4I+PUMc3l6mHsxGEUcpxZor0YHtZeVwP
         tfHrdZWjLnjskGJUcDFqbvg/bqm6W0esxubvxiQ1PB0twQcvchJKHooG9U5OwzShxhbk
         05jCovZ/bHEMAYhNoQwXTssTz8xi8kByVGMeDoOgocLWzI5fQdO0MU77sE3VgRqJU2aJ
         M5b9ovGgH4sS8UW6G9lQTy/5Fft2B1eV76pPUtn4lGvojKdlGTmmthOx0VsTgWHt/Qz4
         y8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EL21QfEsF3+PJl4EwgnGamYd1DQ9r89UbV2SxaWpqOo=;
        b=Umbq/hbBqZPMwErHInHrWCfWVKDR5q6hqa7MVBwY/abSjha/RchRA2XNY2piAEZa2e
         7kqckbO2xZ6mp944tN7mEwqBRszPiTJA2VLIQXxd/Xr2chZd0Y1cZMKuSt8mpqw1t5lc
         2i6IivdGHZU/0DlGKj1qlLVGCaNLgYyOMldiWgFWASLywxSXcL6gxFHtubI7LJ8HZT0s
         Wd+HFyxE42rp1vyyHUrHk4ThCU7wvstOD2OIDA3nhWZt+rL35IPDOxeBr1pxlZ0udTM1
         knr9BGjBrlKOU+nWZSTX7xBlfeVqJqlx+O17/X7/CGlwnsNajVP4iVxded5837rNLHDx
         h35A==
X-Gm-Message-State: AOAM531LKRg4qfIO8Uki7MrdIubwNXqyzKbFN9Ehp6FW/xD54Vxy2pts
	6gHS6jvifdKetHLA42PqtNqvi/MBHxpB3SUxg6A=
X-Google-Smtp-Source: ABdhPJzw7mTdzmLUuxXS5GNLY6RdS98zx0C2M1WCxZdLw9WBUIDsAQ6V3S2wfCP91RqDIRmb5b36HQ==
X-Received: by 2002:a17:907:96a1:: with SMTP id hd33mr3013957ejc.68.1623422373227;
        Fri, 11 Jun 2021 07:39:33 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:26d4:4bdb:59fd:ed42])
        by smtp.gmail.com with ESMTPSA id k21sm2655744edo.41.2021.06.11.07.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:39:32 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v8 mptcp-next 0/4] add MP_CAPABLE 'C' flag
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <cover.1621933974.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <5af8e6c0-83fd-3a3d-18b4-bac66863f8b0@tessares.net>
Date: Fri, 11 Jun 2021 16:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1621933974.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 25/05/2021 11:17, Geliang Tang wrote:
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183
> 
> Geliang Tang (4):
>   mptcp: add sysctl allow_join_initial_addr_port
>   mptcp: add allow_join_id0 in mptcp_out_options
>   mptcp: add deny_join_id0 in mptcp_options_received
>   selftests: mptcp: add deny_join_id0 testcases

Thank you for the patches and the reviews!

Now applied in our tree with the additional Squash-to patch:

- 02acfcf0689f: mptcp: add sysctl allow_join_initial_addr_port
- cd1b6f6c2d8c: mptcp: add allow_join_id0 in mptcp_out_options
- ef3b48916d09: mptcp: add deny_join_id0 in mptcp_options_received
- 0704c54e490d: selftests: mptcp: add deny_join_id0 testcases
- Results: 1ba3eb627299..ae2f6282fc03

- de073c6ce650: "squashed" in "mptcp: add deny_join_id0 in
mptcp_options_received"
- Results: ae2f6282fc03..4e92195bd477

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210611T143831
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210611T143831

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
