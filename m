Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF22C9E
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 12:27:10 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id o4so8873886wrh.3
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wbsk5o6KgdL4SnufubuiVYM7EL+gtXq5PDT+l+PqB58=;
        b=G39QUtITWY0/DbOcOb//w+M4CHOPXvYEoF0ubU5juOPNHcEYSrbvs643OgfKroXIDK
         HCnkbocFpkO8zOxae0uYMUwDCj8D8+g1OP5T04xB2IOh8VzD4Kq43QVYZduOEWxxN3n2
         TXvgzj0sEK993zoM4sITfkxNnS4p0fDaE/Or310c/w8ffN8kd0jI/k6mByuoK5jorTYh
         MXJxNy/srJ7sIfNNF2DN+XQmh/VGhAyTT+gdbvkIJbgGVGPnLN3p4hqfc0GcZuziZcYO
         zjntYDlGC9aTnlmUUrOEw7yZz7SHrfAsJcfhxAtYalKS4GetimgBD5h6UWA24P8f5RpN
         OI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wbsk5o6KgdL4SnufubuiVYM7EL+gtXq5PDT+l+PqB58=;
        b=KogZR8SyvNwryEqFvPvPkHhjFNmU89jpO8UQrngECS2sc7jvA35oGx6wjyx/NX0kop
         cpB5IGw2PJmB/+SJ94Ou5mgzncVwFIJQqPLeVlmE2/mrIp4ioOXSHvn4AcL0pTS2uw6A
         +O0TS2aHNMvsaPIT9lESpvpZBwdXvqiiAvcIbvhtwdkEznj9k2ZCRml9liyVh1gMLXul
         rvZ0HFpsWUaUBF43Czr2+7UScSG/DpJPaEC7W7YCW0SLQ1ZRY63RHQq0ljlGtUzK5QyD
         oqMNcdPIFGYoydfOs5awazP7ht8YOz9JRX57Ft0QEwD0NfgnwsiTas6Gx33rREVy65WK
         KSkg==
X-Gm-Message-State: AJIora8w08hHDu63acLxYZw6TP1J0Jt5IBimPkQZBjuW+CO3zWMZDyBl
	oS4z66b9kE1ISCkvtyk+PuO3Yg==
X-Google-Smtp-Source: AGRyM1s10QCPtzo9j4RkTgku5PKsw19klOZT3gv3QSpsPaPKYe0nS6sDZVGtf8it5iJlLaSmpS/klg==
X-Received: by 2002:a5d:6da8:0:b0:218:510a:be9f with SMTP id u8-20020a5d6da8000000b00218510abe9fmr12054141wrs.352.1656332828373;
        Mon, 27 Jun 2022 05:27:08 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0021a38089e99sm10360546wrp.57.2022.06.27.05.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 05:27:07 -0700 (PDT)
Message-ID: <c1fb40e6-7bab-20a3-febe-3af3b84fc2cd@tessares.net>
Date: Mon, 27 Jun 2022 14:27:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH net-next] net: mptcp: fix some spelling mistake in mptcp
Content-Language: en-GB
To: menglong8.dong@gmail.com, kuba@kernel.org
Cc: mathew.j.martineau@linux.intel.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Menglong Dong <imagedong@tencent.com>
References: <20220627121626.1595732-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220627121626.1595732-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong Dong,

On 27/06/2022 14:16, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> codespell finds some spelling mistake in mptcp:
> 
> net/mptcp/subflow.c:1624: interaces ==> interfaces
> net/mptcp/pm_netlink.c:1130: regarless ==> regardless
> 
> Just fix them.

Thank you for this fix.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
