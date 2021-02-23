Content-Type: multipart/mixed; boundary="===============2511040300863668263=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: free resources when
 the port number is mismatched
Date: Tue, 23 Feb 2021 10:45:52 +0100
Message-ID: <b45e487f-560c-8576-ed25-5641c7e1d189@tessares.net>
In-Reply-To: 1080938f95ce04a83fcf6e874862b49f60ce7a82.1613620817.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7920

--===============2511040300863668263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 18/02/2021 05:04, Geliang Tang wrote:
> When the port number is mismatched with the announced ones, use
> 'goto dispose_child' to free the resources instead of using 'goto out'.
> =

> This patch also moves the port number checking code in
> subflow_syn_recv_sock before mptcp_finish_join, otherwise subflow_drop_ctx
> will fail in dispose_child.

Thank you for the patch and the review!

With a bit of delay, sorry for that, it is now in our tree with Mat's =

RvB tag:

- f1d648a8fc68: mptcp: free resources when the port number is mismatched
- Results: 45795e8f868e..08fd790ee3b7

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2511040300863668263==--
