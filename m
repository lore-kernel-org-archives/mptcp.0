Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E55CA3
	for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 18:11:07 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id n130so512346yba.10
        for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tBL3aRwUgQUHuZUNC4jwdua60RCbVw2xqjxs/jrsiOY=;
        b=Ozit37Lg3V8qNDWvugetwUYRsrSuzY3/T4X+wJPki5rL49iKw7VRXPMPkfVl7MLBL4
         cKnH0mQSDxAWAiibRbuL17a8xBLn4oP/qs580GwUAHJDppZRwkQu4oPsJJGIQ8pjTV7/
         gyIX+o7BAhaL5A8Y0F19j8/WvLwzK/dR1dVV/lgeM7EXY4M71VL1PJ+qrs3FyidamHDJ
         3+cNXYSnJ6kLXx7JiykwfChelyaKVzNxBl56ebTQ5KwJ/IoC5HsyKMrQ0kqUmnRDFLyb
         cbVWbLkl12SjCDahuVZ1TlyJ4jyp8MTqZ9uVowqZjtT8BkDgN98dr8mcVngc9ssV1J43
         Ecpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBL3aRwUgQUHuZUNC4jwdua60RCbVw2xqjxs/jrsiOY=;
        b=sbDkBsn+fIo12hLprySxptutmPK76PErpr6j8oapcUF20XxZDCs7VUK3XxETnA9a1v
         q2entq/Ty7jhZ9cy77DmG24n8C9WT+JOn0JPirxWzObWwZeqlEUrA1lCPjMESGoUhbXd
         YPUW3qmeb7xkYweEuuPWH2iMrIlAR1f+ywzMkRbuUKkc1kJc1YP/OJ/IYD/RzPUBC42F
         A5LEsZJS78sKmWPynukUOFEkBuiiMmm2iEYgiPd6n4/iDG/ItRSKzE06WAKdK5g2QnIY
         5qo3muq6mlT58bfwRC/p76hj8J1cDva+X/GfEtIEHiUAryOOKsJ7bqA1MbDEJnBGVwmg
         zWRA==
X-Gm-Message-State: ACrzQf08GsYmOhRlRIj++EQ17gxkskbEE1FJuA6P+4YkJRJ0MzPu/mZb
	rsu/PI6pqXs7pNKQfG8FnyX9Sqm1OWkGkXzqhLWgXA==
X-Google-Smtp-Source: AMsMyM6wiAHXJPANGgJl9CjkzhwhrSekfszm2WhY2dqHdR7RzVOaNo2QG3mCMmGpgPtExYhYBOw5u1q3kklsXZpAsbo=
X-Received: by 2002:a25:3187:0:b0:6c1:822b:eab1 with SMTP id
 x129-20020a253187000000b006c1822beab1mr11892405ybx.427.1666289466590; Thu, 20
 Oct 2022 11:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1666287924.git.pabeni@redhat.com> <2dede94e742d8096d6ac5e0f1979054ee158d9a8.1666287924.git.pabeni@redhat.com>
In-Reply-To: <2dede94e742d8096d6ac5e0f1979054ee158d9a8.1666287924.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Oct 2022 11:10:54 -0700
Message-ID: <CANn89iLSgJSqc27UYDJ26YeinSzBWtDH6sj1KAHuuAkCmxuwpg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] udp: track the forward memory release
 threshold in an hot cacheline
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 20, 2022 at 10:49 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> When the receiver process and the BH runs on different cores,
> udp_rmem_release() experience a cache miss while accessing sk_rcvbuf,
> as the latter shares the same cacheline with sk_forward_alloc, written
> by the BH.
>
> With this patch, UDP tracks the rcvbuf value and its update via custom
> SOL_SOCKET socket options, and copies the forward memory threshold value
> used by udp_rmem_release() in a different cacheline, already accessed by
> the above function and uncontended.
>
> Since the UDP socket init operation grown a bit, factor out the common
> code between v4 and v6 in a shared helper.
>
> Overall the above give a 10% peek throughput increase under UDP flood.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>


Reviewed-by: Eric Dumazet <edumazet@google.com>
