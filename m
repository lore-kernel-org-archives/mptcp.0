Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632702F80
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 16:44:03 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id 72so7572582qkk.7
        for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7yZBds9lydxwwoqLr0zoPmawjAek+2Vkh5n3xlOr3o=;
        b=X+yAZLY+uvI5S7F+pdIBcYjNLfOKZ155b4U7wi62kL61ME280kBVXMirGgqK8MrFYu
         GsiqeImuJSevCuhrMjoEOycljj0CEvWUu8YwJ1yMGejJnn4pa4fyQJzEkbFf1p5GEiYc
         DgNY359HMQviIJt80jeAmtptEoy8ezNYJYllRTcWHQvlgckDr2cRBuJmNOn4N2P0KCrB
         2HCab35jq7B3uI2SM+RrFM2qSkvdl7jzp47AvvDvXQBJ3Q6cvPzhQTMF/L6mf8oYMeqa
         mZ6lCYKV675N3jshXtz8Q0J6kekAwswr7Z2IxiOaFZw6zgHesaK2zR6OcXnr4OE1HVgT
         ZyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7yZBds9lydxwwoqLr0zoPmawjAek+2Vkh5n3xlOr3o=;
        b=VUgZgc4AwGckIl/cG5jlJqqx7wAjqPvRQJdSCNT080M+Ksz2691vpfcmIxYfHCxHBW
         8WxDqKDsrSf8XMiQdxkeDZ6vuXY/TuTxPEtD1/O8PuGwCqA9fF8HA1H4dRU/Wbx6upWm
         lJEPDpfk5tT8P0krNjwMDDYK4SPuZSPxlFN7RP+/vi9HkMKRBkVDBsjFg1XbTwk9Ru+z
         f0iiWSSMEGaFL3HRULIolrIY+e0FnEaDK2fvjiUxPRvzfrjIVWs+JHpu/1RiE/NCMH0N
         MtTgSH5wB4RsTkwM40ILrQIPx/977kQf7Ud7zUUfec+K+GSueBz4MPF69RDX79em+yHD
         54SA==
X-Gm-Message-State: AOAM532n28PbGHaWlDlzszEGkRVZrAaoQxX9ee1xbMWs6euQCyttHXqf
	zTNiPWZklkcIuZDeSe5aGRsgBfwCn6MrTWAcFOWZhw==
X-Google-Smtp-Source: ABdhPJw+qhgRa7iDjf1PHndTiwVx3p4cESeItjgI93bD49ddqAM0XycaWkxQVE6vgh0rBwZLyhcFvW9+8G2GYztI7cU=
X-Received: by 2002:a25:2b07:: with SMTP id r7mr13038210ybr.296.1631897041942;
 Fri, 17 Sep 2021 09:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1631888517.git.pabeni@redhat.com> <07fd053d2c2239e70b20b105ff6f33d299dabea7.1631888517.git.pabeni@redhat.com>
In-Reply-To: <07fd053d2c2239e70b20b105ff6f33d299dabea7.1631888517.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Sep 2021 09:43:50 -0700
Message-ID: <CANn89iJOtSJ8JFCThtxjRpZQ9Q44LTs-dDxypEA6Hkho9KdxWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] tcp: expose the tcp_mark_push() and skb_entail() helpers
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 17, 2021 at 8:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> They will be used by the next patch.
>
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>

OK, but please rename skb_entail() to tcp_skb_entail() :)

Thanks !
