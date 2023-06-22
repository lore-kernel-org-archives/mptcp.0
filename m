Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F211CBD
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 08:19:19 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51bdc87feb1so1784684a12.3
        for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687421957; x=1690013957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHOSAVpysPPk0w7f3FRoclTHTOeGMXkD/WXz6o43PNs=;
        b=3Qv846galtOKu5j1ZWBEoKDHHvAGKed9GxYf8jtUaOyAmrvsfZjDSr11Mtds2ZkfsI
         z8E8JaX+BZgWcwZ2px/vjwXcVXe/G2papWnvWRx6juFbdgri5wzM8KU/VFH3hTMSEY/0
         VfuMGKTLX1S39ewKkuOV2SpC+iB2Qxt8EdDCl8XAOUYAhUTLDSJj03+VyN3vhCChcTCl
         lrqf85TQV4hEAXb07GWK4bCN0TBaaVw/tm7VOhXosmsRqHnh6sbKdsnQJ3TgsnBbZGFI
         ddqk0x6z9ItamUScnrwLYCUjQwH4H12zJ3Nk3UozHB53yrgaeMe70sas3bN2pKoz74Zq
         Os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421957; x=1690013957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHOSAVpysPPk0w7f3FRoclTHTOeGMXkD/WXz6o43PNs=;
        b=Uqr9Bdc1voTUyfnzEW7tu5osYNxw7w5Qs2c3CdtueQlKec2P5B31KDejjHx3lcse6k
         NhxNBiAtujH76mR75CX277RntvSoGpFwJzZgG201sZRaBtgIwHYLkcnE9g3XB6yyvc6l
         U3ZParfr0anDA+KEg62q+20N5cBeBcXKzjsNBrsmx8tCzxKbw/d9PmrDtVML2c7p5TAW
         QFJ1PLaAnaNrlxfWsCkJqbqASiz3gaWSwZBSRD/Jvu8oNK6J5J9LxyWte61eT4OvwNsq
         PnDLjbwZ5gYfSgEWMw2aSIMAtUoRBSPQzxiGYCJrLIu0h5Hz6ggx8YgO95rIWS8ofCVf
         /bAQ==
X-Gm-Message-State: AC+VfDxV5EXEB11C/PGSywi7/ge38mghM8E5D8NS9Fue7J1Uk62y2WFn
	A9icgYWiNNYRFbNAsUCk6SubkA==
X-Google-Smtp-Source: ACHHUZ5DAgOwgq4jsUtrZx0dccBdImVh49Nsq8bOifuGfOiRsZ8BsC2vF2kKv6FbxkokTfB+nxu/0g==
X-Received: by 2002:a17:907:e93:b0:989:1a52:72b0 with SMTP id ho19-20020a1709070e9300b009891a5272b0mr7626807ejc.36.1687421957297;
        Thu, 22 Jun 2023 01:19:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id q13-20020a170906360d00b009827b97c89csm4166097ejb.102.2023.06.22.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:19:17 -0700 (PDT)
Message-ID: <88685bc2-8467-b999-4b2e-91c381c04d8e@tessares.net>
Date: Thu, 22 Jun 2023 10:19:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/8] selftests: mptcp: connect: fix comment typo
To: Yueh-Shun Li <shamrocklee@posteo.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Kalle Valo <kvalo@kernel.org>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <20230622012627.15050-8-shamrocklee@posteo.net>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230622012627.15050-8-shamrocklee@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yueh-Shun,

On 22/06/2023 03:26, Yueh-Shun Li wrote:
> Spell "transmissions" properly.
> 
> Found by searching for keyword "tranm".
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thanks,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
