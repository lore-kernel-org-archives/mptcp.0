Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81B2F21
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 16:32:09 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id y4so91930905edo.2
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680280328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvi68iJKAS/25m74mr4MaH3FgqvK4PFrC6gaqF8FoM0=;
        b=Thx1oNAabMMlroKPC+jCusrNPKmoeGWLkhJ7nCdgChI0/i26xqlLwjDNDJGKAvexbQ
         HEbNxLO0fVVlhYL1zLAv7mEB0Ev/CQGHZ0CBtZox/XQiqCMFjdOmh6vxlf6LSnH4i6vZ
         lQJNHOdJijJ+QMTHJoyxmePPi6Isb1qf8YVH/HlQisT3w0t4/RG7nxI7S5Jl6qRSYwoO
         REu2RPZExPZ/CSxE9YcpaG9NUIERX0scSE19hFlW8RPXo5cLFfpfjreKTS6VyPh2H5kz
         hM7Pvel1OprwE52dhk6xHgY11N4EajuiQRiVSLlafGWVmhalsRexd6y0/w5b+GQbPctU
         hogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvi68iJKAS/25m74mr4MaH3FgqvK4PFrC6gaqF8FoM0=;
        b=kdjoJ2ADCc2fsTKxS26utH7FAa2JeZZURo08kWpksj+1xFANnYhw1J6929jOu5/6B0
         CHqL9+IfauzDYeF0q4FIbmnMJ3L3EyrdJZWyb3ciQplzvndUl4pcCnzhx/bFZ/T0jEE5
         8KvqeuedwcHCfYp7rTAIStPDNFlgCY74u6DF4YbAsax0KCaOL66afY/sHEY7r7NMN7jk
         NjOFEyxRDRZeoXKhTUvppAe2OMAcQgNjT0XjzL6VK9pMiDl+7z8L7BFffJxENY3xYrYf
         6HVciSsnzzhgR71r/dlnnUMvTd54YMVIvzCBQefykRfXGJFVmAYyRyoh4QQ7OhATb6jH
         4XxA==
X-Gm-Message-State: AAQBX9eZNs0VScyQ+K/DvIP3aFb3Gc7w71yLssNkM5VSp04XFqvzuYDW
	msyl62RMz0ccM3K6R6BWHwRIqNGNX3yeggK6NMXdxg==
X-Google-Smtp-Source: AKy350Yf6gzRpNgpSfoZJum7cpaQXD2sM9Le3jhuamdR0R469+hJYXJYbqAkeLwM3qwxBakj4nscsA==
X-Received: by 2002:a17:906:4b08:b0:928:796d:71e8 with SMTP id y8-20020a1709064b0800b00928796d71e8mr26458785eju.3.1680280327859;
        Fri, 31 Mar 2023 09:32:07 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s18-20020a1709067b9200b008b904cb2bcdsm1162527ejo.11.2023.03.31.09.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 09:32:07 -0700 (PDT)
Message-ID: <1d475d81-4d40-7256-f3d1-9e42dba6a6eb@tessares.net>
Date: Fri, 31 Mar 2023 18:32:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 mptcp-net 0/2] mptcp: a couple of fixes
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <cover.1680204074.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1680204074.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 30/03/2023 21:22, Paolo Abeni wrote:
> dump cover letter to trigger the CI, see the individual
> changelog for the details.
> 
> Note that patch  2/2 introduces a behavioral change that hits
> the packetdrill test close_before_accept.pkt. The msk socket
> will be CLOSED after accept if the first subflow is closed
> before accept.

Thank you for the fixes!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (fixes for -net) without a few typos spot by
checkpatch.pl --shellcheck.

Please note that I had a few conflicts when applying them to -net. I
hope that's OK, please see below:

New patches for t/upstream-net and t/upstream:
- dddea846b342: mptcp: stops worker on unaccepted sockets at listener close
- 87668b995225: mptcp: fix accept vs worker race
- c6a6d1debd0d: conflict in
t/mptcp-move-first-subflow-allocation-at-mpc-access-time
- e04e8b8fb4b8: conflict in t/mptcp-refactor-mptcp_stream_accept
- Results: 199eed4f57e8..f01e02dfadff (export-net)
- Results: e2a442363ad9..68957ea8fdf9 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230331T162750
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230331T162750

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
