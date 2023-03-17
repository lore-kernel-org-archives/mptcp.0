Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C97475
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 17:47:20 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id h7so3149132ila.5
        for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679075239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93R1RrX9I3twrt6aZ9BIfES4YHf18kk5Xpf+bgkTsFA=;
        b=PD2qfnUU+81DGZ/Rvuz7qAyKjlQLcMvc05j/hoDjoEwA5eiuB0I1CbqP7XBheMmXke
         g5dra7fqS9CghgxlYmNg2qYY2brMqznNLefc6ZOqGnLT6MPAiGHkNQ6gx+PrhMGdnVXM
         skpscbwOFb1soXAcNdPBSttVtIpeHuSZSVYvpKCe36FhLxeHbLLCEjx7Ovj5M80ojbI2
         qWn3hLvatynKRnmwdmyN8Y+O0IF8G97clik6e2tlJsAgtwyWLY2vEbcgkl26NDTOlwic
         sCXyED2OoJlrkuuQIWybn77SwfQeWxZxjZsMdDQhY8XbD7aiy+QPjQfT0dyrw30DICXK
         y4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93R1RrX9I3twrt6aZ9BIfES4YHf18kk5Xpf+bgkTsFA=;
        b=CmcMR6PF9TgOrmJMx0EPEsBOLsRdf0HaxxBb9tbh0nF7vNCK7usQCDAVvMIhqbkPjM
         2jQ0dIagYrlzrMHZ2Jmi0xp5Kr7ede3NJ89gzq5uasHaYxH3xq3dcGXLt1xuwgMQUctv
         ZdWf1U79uFs+F3HuuWPXYWUkWkf9coK5H2+ZwM1Am0XAQDndMkvpDqKRQAJNVyxsdLSb
         x8JlAKQFhN4J4FoXPe5WOZpxRc/q1ql1rKaxh8NJGLH9wo3AbXHIIl6bUiz4BQMSDMcV
         UjF0Nb4qOKjXWNI34qcSnc5bf9NQVUrWt2fwzQKoS5Qy0VnmpOYytYQXy8VswhYzfXD7
         s1+A==
X-Gm-Message-State: AO0yUKVInJ/+ZDq2BijupVw3+AzCJRUCh8AC1/ta3xS0SQRzDtfWJoFo
	1b/TCQ2Sm6A453T/uZHc8dcoVstnb96o/e7giQd6ug==
X-Google-Smtp-Source: AK7set/Jf6pm6FDlnwo8nSk++N9Z/WXrdCRhRo1Z1cj7Y9sWFycQiIrzO9PAtL4vAzyIXcVhNzhnbH2clf7P5qUrcek=
X-Received: by 2002:a92:7b04:0:b0:310:a24c:4231 with SMTP id
 w4-20020a927b04000000b00310a24c4231mr130240ilc.6.1679075239439; Fri, 17 Mar
 2023 10:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230317155539.2552954-1-edumazet@google.com> <20230317155539.2552954-10-edumazet@google.com>
 <b9b3e7a2-788b-13ca-91a6-3017c8afbbf4@tessares.net>
In-Reply-To: <b9b3e7a2-788b-13ca-91a6-3017c8afbbf4@tessares.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Mar 2023 10:47:08 -0700
Message-ID: <CANn89i+xOmDmD2=1EQF0U5F5+GQb_HfAWmQD=1FP+6L=qK-E5w@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] mptcp: preserve const qualifier in mptcp_sk()
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Simon Horman <simon.horman@corigine.com>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2023 at 10:32=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Eric,
>
> On 17/03/2023 16:55, Eric Dumazet wrote:
> > We can change mptcp_sk() to propagate its argument const qualifier,
> > thanks to container_of_const().
> >
> > We need to change few things to avoid build errors:
> >
> > mptcp_set_datafin_timeout() and mptcp_rtx_head() have to accept
> > non-const sk pointers.
> >
> > @msk local variable in mptcp_pending_tail() must be const.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> Good idea!
>
> Thank you for this patch and for having Cced me.
>
> It looks good to me. I just have one question below if you don't mind.
>
> (...)
>
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 61fd8eabfca2028680e04558b4baca9f48bbaaaa..4ed8ffffb1ca473179217e6=
40a23bc268742628d 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
>
> (...)
>
> > @@ -381,7 +378,7 @@ static inline struct mptcp_data_frag *mptcp_pending=
_tail(const struct sock *sk)
> >       return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, l=
ist);
> >  }
> >
> > -static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock=
 *sk)
> > +static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
>
> It was not clear to me why you had to remove the "const" qualifier here
> and not just have to add one when assigning the msk just below. But then
> I looked at what was behind the list_first_entry_or_null() macro used in
> this function and understood what was the issue.
>
>
> My naive approach would be to modify this macro but I guess we don't
> want to go down that road, right?
>
> -------------------- 8< --------------------
> diff --git a/include/linux/list.h b/include/linux/list.h
> index f10344dbad4d..cd770766f451 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -550,7 +550,7 @@ static inline void list_splice_tail_init(struct
> list_head *list,
>   * Note that if the list is empty, it returns NULL.
>   */
>  #define list_first_entry_or_null(ptr, type, member) ({ \
> -       struct list_head *head__ =3D (ptr); \
> +       const struct list_head *head__ =3D (ptr); \
>         struct list_head *pos__ =3D READ_ONCE(head__->next); \
>         pos__ !=3D head__ ? list_entry(pos__, type, member) : NULL; \
>  })
> -------------------- 8< --------------------

This could work, but it is a bit awkward.

mptcp_rtx_head() is used  in a context where we are changing the
socket, not during a readonly lookup ?

>
>
> It looks safe to me to do that but I would not trust myself on a Friday
> evening :)
> (I'm sure I'm missing something, I'm sorry if it is completely wrong)
>
> Anyway if we cannot modify list_first_entry_or_null() one way or
> another, I'm fine with your modification!
>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>

Thanks !
