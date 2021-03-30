Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD670
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 13:43:26 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id bf3so18270638edb.6
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+gX3tGk024+xuLurBbHtaZUuxCw57suIdRETXQKRYw=;
        b=DmweP4jYcje5kn4SpE9zEt8jTpNi0pDYYsDPY8MjpTacb3lYmOsJwCiNExXvI8kTB9
         R3VoUb8qC5sjvKrdjfsQdeS/7fJLg4teXwO/YTZWZc1nlmgrQZmwr9v0nnOzeFPGGNph
         u1DYC1XWGBb0JFgXm1mc5NPHOovYa91ZPJ5Hm0Wr7ULvsaKPsNDsHEpY5G7mRTZS1xx7
         tQkkxt3cptJfuYthnAwVh6wLzixY3u9nX5KhOuIbRqCBRPViMaunM8QjGziAesqB4Edg
         fwByIcq8NveLgJBa6wp01kGggOHe60Fn8CedFsm+9G7iFsvQkCmgx7VBNXbxrJme9mdV
         m53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+gX3tGk024+xuLurBbHtaZUuxCw57suIdRETXQKRYw=;
        b=KlWsBbtZwDWJI1CHIP7Nwv5liR7PqkFT7ccuYK83yxjkyPtBDJprUc47gtYz9pAz77
         agTxWhSSr+j/+6vySRp7xdzerCdowrw9yMM0hwnUIVAdhnkI6QiSG47aoLIUwFpGEHuJ
         kAwXbkyqy+aNTd4H8M/S9iECddHfSRDS5zUaDmL+wyUSJFCw64mIAK+t/193ADqAmIeQ
         z74GLZzqZ00/hruj968w0c37985yfH3wBRnqinWOu2N9x0QKZFmnZoC/nJ+KLrV98YEm
         bdcbsssnKh7oMiTF2fMW62vbaJCaCBmfKxWIcHk0dkT7Q3LR62avEqDQPKlJMrBS4yLg
         uYNQ==
X-Gm-Message-State: AOAM532PiHpippgfZQir/0UVEiDKK5nlQ2RkbDd4G0oUyp4N4mle2Hae
	3yHq/ZS0d9DuX/JvCWLZ5pteZHOsA9R6eA==
X-Google-Smtp-Source: ABdhPJyEFp5DYs14oJJIZ8Js6oyHWKDzkfVFKVhEx4yd67HMPqd+q7dmxWPgAjs2u99h0zOxp0+noA==
X-Received: by 2002:aa7:cc94:: with SMTP id p20mr34381089edt.353.1617111805374;
        Tue, 30 Mar 2021 06:43:25 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8c77:a440:107c:fad8])
        by smtp.gmail.com with ESMTPSA id p27sm9993225eja.79.2021.03.30.06.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 06:43:25 -0700 (PDT)
Subject: Re: [PATCH net-next] mptcp: drop all sub-options except ADD_ADDR when
 the echo bit is set
To: Davide Caratti <dcaratti@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8305391c-1c1b-1308-a0df-0a963722acdf@tessares.net>
Date: Tue, 30 Mar 2021 15:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Davide, Mat

On 26/03/2021 13:28, Davide Caratti wrote:
> Current Linux carries echo-ed ADD_ADDR over pure TCP ACKs, so there is no
> need to add a DSS element that would fit only ADD_ADDR with IPv4 address.
> Drop the DSS from echo-ed ADD_ADDR, regardless of the IP version.

Thank you for the patch!

Now applied in our repo with Mat's RvB tag:

- aa44e0298e25: mptcp: drop all sub-options except ADD_ADDR when the 
echo bit is set
- Results: 01e1b77c047c..ee61d54be9fd

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
