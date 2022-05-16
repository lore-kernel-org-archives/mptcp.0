Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046542577
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:47:45 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id z26so17579006iot.8
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXCsccIRv/oRQ4k5XyZPds/zrCr9HYqlNJkf3+MT3ZU=;
        b=knKjM4jo64KbuqHxsCnj3gpGu9VJneQCaN/SMPJVzUdVIFcgWg83759h0w0wdNO+3B
         U0ZgDckE0iPZK33pREqfzhWhxcrn4DtQM0y5f+Xsn6aDDXBP8alnnVeNB3rXlMeOT8vu
         l0fFvEcDHo82KCMnXpGfh5ebaoGHRrn6cCsYDuJyutcq0QCIgaGbFXaCjxdqz/ynpZqf
         ECZ7fRLV9JcdM50DsAmFeXE3LxGLXyxEDKW8ZyVcAA+B3RgSfSLf9qBMdvky4PaFwILW
         E9sXd5flvwfaGCyVQpdOtxIKwPPR3EIlqHj6NV4widqVc0GMC9dRF3tfjbc0/1gzklgx
         nv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXCsccIRv/oRQ4k5XyZPds/zrCr9HYqlNJkf3+MT3ZU=;
        b=ym1ykrBhJ35KJV+P/WTyzbAdQkXXVcr1oQ6JZ+uivyA1SOPbGTkuGavUkedb/gwgfU
         599qt6X6Kmxwr7EfqfHqHubok1gXP6BNWRhu0SRV27BrECo/A5rR/GHKv4z500tT3AdZ
         o11V0TZYBCX0fQyOOYZjxKzSYaMYFY9SzBwTcAyfj/U633cwVtYvcLj6BKPeVQMG7PMZ
         40WzWD2ZQY2oiLvXMxMn4/aZJIl+Fh7M9nzltj2wID5AnItcTZNVRlOOE1S+g2g4M0Nz
         BUQnf4yHYC5tuBBOeZHTE4SuW1j0bXpx8yPoWqwxZ03bZlx5tpzHUA3hJ5y/2XnWIVGN
         ebKw==
X-Gm-Message-State: AOAM5304DLgOrAi+OClpoEMG68yMXozf3ZychCD5LugkqnvYnPM4iDvf
	AtF2qr7TOGXl7KTDVnJlBwwZ6+X10Aq1As4T33s=
X-Google-Smtp-Source: ABdhPJzXurvnQTVLbZLmRa1uP13vbh/prUlGz7ViD6y8C0tp2etwbsn1aznZEMOq6h06dLG0px8JjzIx9JhL0kBP7qA=
X-Received: by 2002:a05:6638:468e:b0:32b:fe5f:d73f with SMTP id
 bq14-20020a056638468e00b0032bfe5fd73fmr10707056jab.234.1652741265081; Mon, 16
 May 2022 15:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com> <20220513224827.662254-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220513224827.662254-5-mathew.j.martineau@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 May 2022 15:47:34 -0700
Message-ID: <CAEf4BzaMz=CR5H=_BXgQ8UfDC6mDawgNbGb5XyYBOBqkkS83Hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/7] selftests/bpf: test bpf_skc_to_mptcp_sock
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, May 13, 2022 at 3:48 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> From: Geliang Tang <geliang.tang@suse.com>
>
> This patch extends the MPTCP test base, to test the new helper
> bpf_skc_to_mptcp_sock().
>
> Define struct mptcp_sock in bpf_tcp_helpers.h, use bpf_skc_to_mptcp_sock
> to get the msk socket in progs/mptcp_sock.c and store the infos in
> socket_storage_map.
>
> Get the infos from socket_storage_map in prog_tests/mptcp.c. Add a new
> function verify_msk() to verify the infos of MPTCP socket, and rename
> verify_sk() to verify_tsk() to verify TCP socket only.
>
> v2: Add CONFIG_MPTCP check for clearer error messages
> v4:
>  - use ASSERT_* instead of CHECK_FAIL (Andrii)
>  - drop bpf_mptcp_helpers.h (Andrii)
>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 45 ++++++++++++++-----
>  .../testing/selftests/bpf/progs/mptcp_sock.c  | 23 ++++++++--
>  3 files changed, 58 insertions(+), 15 deletions(-)
>

[...]

> +static int verify_msk(int map_fd, int client_fd)
> +{
> +       char *msg = "MPTCP subflow socket";
> +       int err, cfd = client_fd;
> +       struct mptcp_storage val;
> +
> +       err = bpf_map_lookup_elem(map_fd, &cfd, &val);
> +       if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +               return err;
> +
> +       if (val.invoked != 1) {
> +               log_err("%s: unexpected invoked count %d != 1",
> +                       msg, val.invoked);
> +               err++;
> +       }
> +
> +       if (val.is_mptcp != 1) {
> +               log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d != 1",
> +                       msg, val.is_mptcp);
> +               err++;
> +       }

any reason to not use ASSERT_NEQ ?


> +
> +       return err;
> +}
> +
>  static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  {
>         int client_fd, prog_fd, map_fd, err;

[...]
