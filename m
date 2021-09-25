Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D63FCB
	for <mptcp@lists.linux.dev>; Sat, 25 Sep 2021 08:18:08 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id v24so45560608eda.3
        for <mptcp@lists.linux.dev>; Sat, 25 Sep 2021 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IIneLnUe0h5J1xTCRxILAeudrvtK/rzSYWc/wXRBZDU=;
        b=JWxQH8AMicx++ReRZCiE3NxGYNrJajNk5dbIBxNSEoNvuwLh5xV6ov635iniEdqQW9
         9vXJqy41Zhqzs0qyVtofQ50e1dChKRzVpFGWVCGSAC7U3WrkCSE8WLvU9C3/KLlKPFKW
         v1rv2ETStAf86MUacUM5QVH0FatTfZID2i6g65MMKtWsepDDkeD9KDyqwHmPIPSQWIzp
         xqLbu7BdTmIWhvsdwlNS49TNcYG7ekZssTDsqyDtLuyEbqLKsNsPjgo55oN34vGaKhML
         ecKQYqfqtl57Xh41/R9vv8sIgms/OuxbIams06ONHdul1JDZ4eNuuCkluiOcSV+m81B3
         SzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIneLnUe0h5J1xTCRxILAeudrvtK/rzSYWc/wXRBZDU=;
        b=6XUkO9OhLtjgsS9l3g+eU6rrUgvz3GvJKVA+pOj9UQIXZd280rEvYZCdVophnkk3eo
         lAnkVqd8LryWXCSO62wBDnwgNWlSjgQJt6KX/J804yjltcBdxt2AN/RCaojBMz2ULcN0
         w0kn3c+teLIcbASDRqIQUPRYiTqeje1H7lt6aSgimkH2NR0Ve8TMDkQdFrw5Avq4OI6i
         isJuM6sgTPjP4m7R74KSqbRWndxo35JfPyZfb8GACHlEb1VUQ3f++iabLsrrqYGWl2ev
         mj8jx3qF+mm7xmkYR4NHt3wrqyEtf9zrxIO65LcVqZXb3A1h2ki7XIDKto0N1pCVH2Vx
         SFcA==
X-Gm-Message-State: AOAM533doqN1EN10SdyioNac7MChX1TDDQ/wHcMrC+La1+MhNhfCJGs6
	+yFilVYISDeqbuhAZQl4N9B3XJ86H8kDffu5
X-Google-Smtp-Source: ABdhPJxLXtpC6v9c3VRdBudz37oiINqW4OFL4xLpz5Tu+JVC1HQsYaUXTV9tSSQZWQyAfW3p/7KLwA==
X-Received: by 2002:a17:907:1df1:: with SMTP id og49mr15855237ejc.35.1632557886803;
        Sat, 25 Sep 2021 01:18:06 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id e7sm7817741edk.3.2021.09.25.01.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 01:18:06 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-net] net: introduce and use
 lock_sock_fast_nested()
To: Paolo Abeni <pabeni@redhat.com>
References: <46317e271da725006df9916b2b2c3d334d3616e1.1632490917.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8ff12847-cdf0-ba97-91c8-325c1819a829@tessares.net>
Date: Sat, 25 Sep 2021 10:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <46317e271da725006df9916b2b2c3d334d3616e1.1632490917.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 24/09/2021 15:42, Paolo Abeni wrote:
> Syzkaller reported a false positive deadlock involving
> the nl socket lock and the subflow socket lock:

Thank you for the patch and the review!

Now in our tree (fixes for -net) with Mat's ACK and without a few typos.

- f3e1b10ba958: net: introduce and use lock_sock_fast_nested()
- Results: 9c66f209e7f2..2224c01350eb

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210925T081746
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210925T081746

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
