Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF87E
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 22:07:25 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so212539pjd.0
        for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFAFy2cX6p2TxsPpogzDjs9fiQ6UuglhalzGO4odrnI=;
        b=QDsdbXmsvZ+ZTvzBdxGLT8GWYu85ANRweHrwxsJMFBsiDhJRfQXp7fTKPF7hxLgZ+J
         AmUkpodyJAOcjj6LSJXtHEvp4VUUo5c4M6lnLbeul2NakFsw78nbz416BVzTjObpU/Og
         2+2xRaG6P0tWDL/GSVolA+WfbrFJB9t4gNwddm3qKPz2oEVr6HLhuSezPgPdZBfGERNb
         Hm0xida19crW/LZwfehkRKT/V/WK6UxMwpFWqnsQCV8pKzk0+rDWNvrdA7pRVqVBZh/g
         EUNn78E/O5i8T3oS0K7ORBPxMoLNh6uOc04eli9ywvwMLbxr5OtS59lvzmdlv5fCZRRk
         Dzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFAFy2cX6p2TxsPpogzDjs9fiQ6UuglhalzGO4odrnI=;
        b=hSIFsCWXaTKmCWCVtoPcCa71ZEJ20u0HEWvIufMkFpaey3XCRlutFCfRk63L8ZwOtr
         I7AWH6jCvwaWpwoQTXtVHBxKaPjx593PGsipme/qIVYQ26okYkKwzkyx76vBknWhSrU9
         DKUa5v1LnZKciv4MO0k1oIfLuTSInRSO2W2WuOe4HRWtz9F76wfyJPKertriUHuswhAA
         26ZGw2U4wY3K3QIF426lP21OUf+9TJ5W7z8fCwS58BRNPMla8dJR6SdniPpuWppyP55P
         W2ZlnwB0mAepoeRVY6W8iOpwr2x09pUSfeg2NOc48G+RopPgcIZkm/SgMx8YtsEbUeAc
         jSDQ==
X-Gm-Message-State: AFqh2kqz76Hm0DzbH6wshE4GnF8vHYaslis74Yx3vy/n7X51hH1j/uQZ
	jdrzpC6whI4faqyZ1oUq5n+iWf7cqa7PS+h2uqSq
X-Google-Smtp-Source: AMrXdXsHspUJoS7HSo5OLC8JbdXBJm3B8unlBAtSokp6tcirCSO9Ki89+7LVWXPWIsCTqcqYf1HoTKFzPM5W66dsCSQ=
X-Received: by 2002:a17:90a:6481:b0:221:5597:5de7 with SMTP id
 h1-20020a17090a648100b0022155975de7mr1983156pjj.147.1671574044825; Tue, 20
 Dec 2022 14:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1671469167.git.pabeni@redhat.com> <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
In-Reply-To: <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Dec 2022 17:07:13 -0500
Message-ID: <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 19, 2022 at 12:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Newly added subflows should inherit the associated label
> from the current process context, regarless of the sk_kern_sock
> flag value.
>
> This patch implements the above resetting the subflow sid, deleting
> the existing subflow label, if any, and then re-creating a new one.
>
> The new helper reuses the selinux_netlbl_sk_security_free() function,
> and it can end-up being called multiple times with the same argument;
> we additionally need to make it idempotent.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - fix build issue with !CONFIG_NETLABEL
> ---
>  security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
>  security/selinux/netlabel.c |  4 +++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a9199..f785600b666a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
>         selinux_netlbl_sctp_sk_clone(sk, newsk);
>  }
>
> +static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> +{
> +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> +       struct sk_security_struct *ssksec = ssk->sk_security;
> +       u16 sclass;
> +       u32 sid;
> +       int err;
> +
> +       /* create the sid using the current cred, regardless of the ssk kern
> +        * flag
> +        */
> +       sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
> +                                              ssk->sk_protocol);
> +       err = socket_sockcreate_sid(tsec, sclass, &sid);
> +       if (err)
> +               return err;
> +
> +       ssksec->sid = sid;
> +
> +       /* replace the existing subflow label deleting the existing one
> +        * and re-recrating a new label using the current context
> +        */
> +       selinux_netlbl_sk_security_free(ssksec);
> +       return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
> +}

I thought the idea was to ensure that new subflows of an existing
MPTCP connection would be created with the same label as the main
MPTCP connection socket?  The code above labels the new subflow based
on the current process, not the main MPTCP connection; it matches the
commit description, but not what we had previously discussed - or I am
horribly mis-remembering something? :)

I was expecting something more like the following:

static int selinux_mptcp_add_subflow(...)
{
  struct sk_security_struct *sksec = sk->sk_security;
  struct sk_security_struct *ssksec = ssk->sk_security;

  ssksec->sclass = sksec->sclass;
  ssksec->sid = sksec->sid;

  selinux_netlbl_sk_security_free(ssksec);
  selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
}

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 1321f15799e2..8e0080b8a8ef 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -155,8 +155,10 @@ void selinux_netlbl_err(struct sk_buff *skb, u16 family, int error, int gateway)
>   */
>  void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
>  {
> -       if (sksec->nlbl_secattr != NULL)
> +       if (sksec->nlbl_secattr != NULL) {
>                 netlbl_secattr_free(sksec->nlbl_secattr);
> +               sksec->nlbl_secattr = NULL;
> +       }
>  }

This is pretty nitpicky, but it might be a little cleaner to use the
pattern below.  At the very least I think it tends to better match a
lot of the various free helpers in the kernel.

void free_stuff(void *ptr)
{
  if (!ptr)
    return;
  free_properly(ptr);
}

I would probably also reset sk_security_struct::nlbl_state too, so
maybe something like the following:

void selinux_netlbl_sk_security_free(...)
{
  if (!sksec)
    return;
  netlbl_secattr_free(sksec->nlbl_secattr);
  sksec->nlbl_secattr = NULL;
  sksec->nlbl_state = NLBL_UNSET;
}

-- 
paul-moore.com
