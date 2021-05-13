Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531D2FB1
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 07:42:56 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id t4so38688433ejo.0
        for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6sb5g+0CyBnYgspWb7smnxR0u0kh10bCr5C3KgaiSes=;
        b=nm/LAtXvFRwX89y06H1ALD8Oydr3PR81m/jalrET9VP8ApR7BevglIqGijciQzn64B
         upKkmS18bNy/b+0fc3/ifDaEYUfAsycKQP19R4ZwyDWQjH80pcCFt3scfwEn29A7zEK+
         rRK9JTZ/mGzj+jgrVo9H50ilGZ6U4MnmfrfJaz2D5W1/g7oViKKT/bwfStCqLySDF4FO
         sCbM9gxYYEMG2NrqUxfxzIuJ4hevHulU/U9Bn4fJLg5kUW4klJImje5Xu8WQPl8iImsu
         WojJQ+t8FknVkEOiY21dX8pz9pmmBdw8UBgB362FT1v3nDh7VUCBqjTV9A88uwn9WhNb
         /21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6sb5g+0CyBnYgspWb7smnxR0u0kh10bCr5C3KgaiSes=;
        b=H3RbkFVBBjEzCIWx8X2tTqnzT/3pdiKRCBnJual8kNMtlKED6b/p5HtDaRom+jVerg
         4vUcNk7/8fKtG9xzDpjOAB97/FIMSHCQ6DbrNC139vw8w+Iun/AkLErOr0XDebcQ7GQl
         ux1FcL/EVlzDFOCXJeme47CLB9cyI35XIsXjrkzABFdbDHR5zUiUI76+F0g3F4H9isC2
         GVXBFRlq7NQuMgIeOq4L3Vh3kKkyKUMyrCHDBVMAt4L/K3J5kMvxg9xE6aW77ohKDVsO
         R8xrRG4GvWyEEa5CyJBeEv18UqvdPIXmqxnt+ZkrLUDVbgCcL8RgFqrzaFeRkpLzgroN
         VDmg==
X-Gm-Message-State: AOAM532iurURNbnLyuInIJCmbFbf1HczNiUIMyHDCzGj934FcecVMFP2
	JKTbN8u0p0KHABz7NjzUkEjGeXGteYvcLxqa
X-Google-Smtp-Source: ABdhPJw5nBuMLUOdFcrr4NjleQiiRsCuODoQ92ySXVer204UwXw1r2bX6nVhC0rBuI/Pi/zszt1r1A==
X-Received: by 2002:a17:907:399:: with SMTP id ss25mr42699031ejb.134.1620891775294;
        Thu, 13 May 2021 00:42:55 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8928:ef6b:4f39:1fcb])
        by smtp.gmail.com with ESMTPSA id g11sm1405262eje.7.2021.05.13.00.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:42:54 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data
 checksum"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <ebb1b2d9-7880-ca53-b35e-52eb1a3ebe8d@tessares.net>
Date: Thu, 13 May 2021 09:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 07/05/2021 06:18, Geliang Tang wrote:
> Move the csum_replace2 trunk into the later patch "mptcp: receive
> checksum for MP_CAPABLE with data".
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the patch and the review!

Now in our tree!

- 04461ed21558: Squash to "mptcp: generate the data checksum"
- 2f6a4aa17ccb: conflict in
t/mptcp-receive-checksum-for-MP_CAPABLE-with-data
- Results: 6628a7b4ea41..f8de7f4600ea

No tag, we need 'Squash to "mptcp: receive checksum for MP_CAPABLE with
data"'.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
