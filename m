Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CA29A1
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:45:26 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id y12so9250613ior.7
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9E7RpF3kV6uZXouTfZrM1fmjZpic/OFFP4Rr3o2bqnA=;
        b=LPzyDwK1mHDDhjjzL6eMFYzavfB/+fZqNoysv+PK+BKBqU1s9j6pVjsIslmdAO88fW
         rxzsz4AjZmwzgp9HAIfj5hopHnLycaTWqL2S8kG0quEcq35z5b8Gb2uQwyUxHnQPEDiY
         wyU+A3WmFFkJbSxSM1g+jzBCc/A0ms8mGu2wQAIZYImZZh/AKDQYGHKzwWj2GW/BUQl9
         95s2G5fN8DBb1VcIDYaW9xeXvDlkaHmVSGV8uuxxgDR6AZX0m0XBzjSXf98r2UyKOxKZ
         OcJltAsd9tAn6kwbQYic2BZUOGWHJJPMPx5xUxHkzzTxqWO5foj1MBWpiHYvqrg+T2fq
         7bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9E7RpF3kV6uZXouTfZrM1fmjZpic/OFFP4Rr3o2bqnA=;
        b=4o00qHrkmVP3Z+uvVL1IVyH+xB7WjkI5dk2eJ0NL3/offFMXLQdCDhv2h1/U4qHgWN
         m8B0AHMFo5h6Bd9r88iIxkf6psuMIpju7a2/KkUSgLvy2IcU9Hw1h6ou58IgIYcXKU2A
         xeOWO9JY5WraSb8wxsmFpKJLXZ7COo9K/Ca4zregelt+xoO3DHwI6AYBzDcS9WJ2Eo2A
         DgQLOXA35p2U7YdWHzUK/C2h/dcbYI2iSDzM4a0Bxxxe8aBZZREEe/com2LgH9SU+iJ4
         9Qcynf/3KEIvTlawap1u3gsm037kNAlbUc2pQGv3ks3992xBrgUc0NmFt0MjOiX/x7HU
         sZ6A==
X-Gm-Message-State: AOAM533X/cmb2rz/RydusAIVQXqlgEnF2FjNKwzTpSkBXklcIcAx5ltw
	wcFc2GNG2AwLivqChetZljt8zdZilCmcWtWeRMU=
X-Google-Smtp-Source: ABdhPJw7Fg0ClVP+XC5GPYevvUVOxVKp0UvEXx/7+mToohzRfuFsiF+HjkMYUgcNp8fngXAb8ZOVnj44mK2FXEsEQiE=
X-Received: by 2002:a5e:8e42:0:b0:657:bc82:64e5 with SMTP id
 r2-20020a5e8e42000000b00657bc8264e5mr8838937ioo.112.1652741126084; Mon, 16
 May 2022 15:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com> <20220513224827.662254-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220513224827.662254-6-mathew.j.martineau@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 May 2022 15:45:15 -0700
Message-ID: <CAEf4BzbsK9C1=h=7s25Ezh8HFo7=+vA1XSuLjbQA2Bi16W4kvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/7] selftests/bpf: verify token of struct mptcp_sock
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
> This patch verifies the struct member token of struct mptcp_sock. Add a
> new function get_msk_token() to parse the msk token from the output of
> the command 'ip mptcp monitor', and verify it in verify_msk().
>
> v4:
>  - use ASSERT_* instead of CHECK_FAIL (Andrii)
>  - skip the test if 'ip mptcp monitor' is not supported (Mat)
>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 64 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/mptcp_sock.c  |  5 ++
>  3 files changed, 70 insertions(+)
>

[...]

> +       fd = open(monitor_log_path, O_RDONLY);
> +       if (!ASSERT_GE(fd, 0, "Failed to open monitor_log_path"))
> +               return token;
> +
> +       len = read(fd, buf, sizeof(buf));
> +       if (!ASSERT_GT(len, 0, "Failed to read monitor_log_path"))
> +               goto err;
> +
> +       if (strncmp(buf, prefix, strlen(prefix))) {

ASSERT_STRNEQ ?

> +               log_err("Invalid prefix %s", buf);
> +               goto err;
> +       }
> +
> +       token = strtol(buf + strlen(prefix), NULL, 16);
> +
> +err:
> +       close(fd);
> +       return token;
> +}
> +
>  static int verify_msk(int map_fd, int client_fd)
>  {
>         char *msg = "MPTCP subflow socket";
>         int err, cfd = client_fd;
>         struct mptcp_storage val;
> +       __u32 token;
> +
> +       token = get_msk_token();
> +       if (!ASSERT_GT(token, 0, "Unexpected token"))
> +               return -1;
>
>         err = bpf_map_lookup_elem(map_fd, &cfd, &val);
>         if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> @@ -58,6 +102,12 @@ static int verify_msk(int map_fd, int client_fd)
>                 err++;
>         }
>
> +       if (val.token != token) {


ASSERT_NEQ

> +               log_err("Unexpected mptcp_sock.token %x != %x",
> +                       val.token, token);
> +               err++;
> +       }
> +
>         return err;
>  }
>

[...]
