Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB77B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 10:09:27 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id gh6so2466107ejb.0
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YvwH1vO4sRmLDCJcY5QHloUEWlMKOR8FmFkmLjgmn20=;
        b=KRYxY9ijG1TkmkU0m7KhowpVwFB27UMVl7B4ZmWj+SlAO4gKbobWw7t+kgqtN19rA8
         Vf8CEz5u9vfNrcAbtvl/P5srLn/7kKDhA+09d0ECJ+l4o63YDig+PgApxgu+F1BA+lmc
         MrZKuRc+EZzrmpy8/+NlfpCuWAFAGYuLqjoEgsL8y5VX4oV0IRJS4Tm7nThDo/GHd7bm
         SGzaGo6N8rmixCzP9lli0yFWWlzJEzo3h9hfZt1qCvU0sce82hs5x8iUVjKE7CmAgMj9
         nsx6zVajWSFvauFrfM3v4W6Jd3G6MmKWhSRBGFPgNqzUBJwVpnVtv7bikdBXhEwxaRrt
         QDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YvwH1vO4sRmLDCJcY5QHloUEWlMKOR8FmFkmLjgmn20=;
        b=Wnchn5RkkVKlqAdvGKvono+RmfkPgVLSY/9T6HAZlQJz1lSLq5o+dC/kWIvfqoUnFV
         IZS9EZ8geSoTWOqPMWCytv45Bu6ox2vI81NAeLug/pLSrRqlbqoUwLHop8fkOXpRtjcq
         zYhGNhzUA5Pc7sgURelHbrcwKe/PEJQNk9HWfbDD3cQT94fNQNzg8V31ttVs4PaH7xBr
         UbhWraYTP0Rt1PTOlGuuUO0ozpIVFjs6NFwwNM4Eo9WAWWcMC9YhhhWOaZTUvZbKoBgg
         QOAEK8+69J0VtIyqKGz8Ox4yK+orQQF7ir8uMRNy6NX/533Ny0KdtaTYZTBM3pHMiuZH
         PLyQ==
X-Gm-Message-State: AOAM531EiVudirAq9yTDBKnDwvVag87mNeJfKH+sO3gbX6U9PniQo/jA
	ouoUmzT6/MqwrglFbSptOexMi4mKcjq0T5v7
X-Google-Smtp-Source: ABdhPJzW/tGQkTHAOcMIlJAb1OiVC8jyFevPLfCaok7r7OzHjTaFzLd4QIG5Q3pju7Ub/kLTu8iMwQ==
X-Received: by 2002:a17:907:d8c:b0:6f0:1091:de34 with SMTP id go12-20020a1709070d8c00b006f01091de34mr25467059ejc.376.1651054165253;
        Wed, 27 Apr 2022 03:09:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3b64:994c:90d3:9913? ([2a02:578:8593:1200:3b64:994c:90d3:9913])
        by smtp.gmail.com with ESMTPSA id v20-20020a056402349400b00425a5ea1bb7sm8451235edc.57.2022.04.27.03.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 03:09:24 -0700 (PDT)
Message-ID: <edebd64f-9b82-c4c1-1d03-e39270bf5c58@tessares.net>
Date: Wed, 27 Apr 2022 12:09:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test
 base"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <38168fb95c78454db24726d2bd45f2d65d977fda.1651022882.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <38168fb95c78454db24726d2bd45f2d65d977fda.1651022882.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the patch!

On 27/04/2022 03:28, Geliang Tang wrote:
> Add CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC as Mat suggested.

Mat's second reply on...

  Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"

...patch confuses me but I think he meant: we need this patch as it is
and that's why it is marked as Queued on Patchwork. But for this fix
here, it is probably best to have a dedicated patch and not a Squash-to
one because these two config should have been added before as they are
needed by other BPF selftests.

Did I misunderstand?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
