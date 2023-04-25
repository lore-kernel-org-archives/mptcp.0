Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863816ADF
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 15:25:55 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso3725567f8f.3
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682436354; x=1685028354;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5kUJMA1pe76+w0V+odr3AJVt/Z03MSZReAs2fi0Sok=;
        b=g9Ug8MkfP6hPOQnLEsBz/NmlyfKqgSHr/64I4kao7Vm0+Uv/hA0dlhrA4eTkRukHAo
         D/Brqk2dsh+9tjo4+CE+HzBn3gKacWOlP4dxYukU8pDa0K3nlSLN27p+2uI1uVnVQ1Tr
         QdoX+DyLO88AhgQx2AS23dJh9BUd9ybhyGgk4gNm6n0LGf5otro5xyD6/iUlS4Bw53wA
         hXP9VJywlNbrus7i1P5p/h5OZBHlVdwcC0TjLryocFpV13n6IRw6j9Ppp8KTkhgZhOrL
         JB/o3PpTTqKczauubRaNmJ8iowxtSSYCRJOr5gXDJddygrbHf9HRNwX08pZgqwafmLJN
         1VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436354; x=1685028354;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5kUJMA1pe76+w0V+odr3AJVt/Z03MSZReAs2fi0Sok=;
        b=YoqV1YHFRzaHoelW+Vj7tiJWeVzbXCKGrrBIYW5asP0d7DU8rEuzWo6ZPFxAziBEiY
         KOzpyIXszmmrSs1MZB4O3w9YNJjZiVXzxGVBFJzUYiIOAC8IVSs+uXhM+Le/6Rlj7fhb
         MHwJCF6n188yLjHcKSqGruosMLG+e7MeIrrTBrp3CQQjqjDJmogHDtjI9wqhcr650+9J
         g6vGpq7tqZZUAlA5NKZgZM2pC2or1/le4IdXEAljPLcVVtfxylAvtO+eXMqzA0eltF+9
         o6/8v8WUVPC6XPyVEfmfQE9hebsBALKQXYurjHXpAdFF0cttDTSxaf5Hi0KYpynFncLG
         txKQ==
X-Gm-Message-State: AAQBX9cIS4pMpnx0vCvPinTeRIKOZL+gySTjdbOQGQxi8uXQc3EtX/FK
	hcTKZVIYq8LwzsLgb41u1CQEcw==
X-Google-Smtp-Source: AKy350bI34QTIO+Lp+4tXn+CM4UqYaTfAw4Q33dNBmLChI/YgYamGr2fHkBUsCgUbLSVkgkGS+pYLQ==
X-Received: by 2002:a5d:4f8e:0:b0:2fb:2567:bc1 with SMTP id d14-20020a5d4f8e000000b002fb25670bc1mr12518028wru.8.1682436353692;
        Tue, 25 Apr 2023 08:25:53 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id he13-20020a05600c540d00b003f198b9eac5sm9694681wmb.6.2023.04.25.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:25:53 -0700 (PDT)
Message-ID: <3e7f3e1f-9729-97e6-4209-62c058497671@tessares.net>
Date: Tue, 25 Apr 2023 17:25:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v9 5/6] mptcp: add addr into pm anno_list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682409247.git.geliang.tang@suse.com>
 <9bbb727d7115d7339bfa91bd61ba85386e998aaa.1682409247.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9bbb727d7115d7339bfa91bd61ba85386e998aaa.1682409247.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/04/2023 09:55, Geliang Tang wrote:
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.
> 
> By doing this, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.

The reason given here is the same as the one from patch 3/6. But then
what's the difference? Does it mean the patch 3/6 doesn't fully fix the
issue? What does it not fix and what does this one do?

Or does it mean we should squash patches 3/6 and 5/6?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
